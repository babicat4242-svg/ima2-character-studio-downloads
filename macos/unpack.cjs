// Read the verified release's ASAR archive without publishing its contents.
const fs = require('node:fs');
const path = require('node:path');

const [archive, destination, codex] = process.argv.slice(2);
const data = fs.readFileSync(archive);
const header = JSON.parse(data.subarray(16, 16 + data.readUInt32LE(12)).toString());
const base = 8 + data.readUInt32LE(4);

function extract(directory, relative = '') {
  for (const [name, entry] of Object.entries(directory.files || {})) {
    if (name === '.' || name === '..' || name.includes('/') || name.includes('\\')) throw new Error('Invalid archive path');
    const item = path.join(relative, name);
    if (item === 'node_modules') continue;
    const target = path.join(destination, item);
    if (entry.files) {
      fs.mkdirSync(target, { recursive: true });
      extract(entry, item);
    } else if (!entry.unpacked) {
      const start = base + Number(entry.offset);
      if (!Number.isSafeInteger(start) || start < base || start + entry.size > data.length) throw new Error('Invalid archive offset');
      fs.mkdirSync(path.dirname(target), { recursive: true });
      fs.writeFileSync(target, data.subarray(start, start + entry.size));
    }
  }
}
extract(header);

const main = path.join(destination, 'main.cjs');
const source = fs.readFileSync(main, 'utf8');
const windowsBinary = "path.join(app.isPackaged ? process.resourcesPath : __dirname, 'runtime', 'codex.exe')";
if (!source.includes(windowsBinary)) throw new Error('Unexpected application version');
fs.writeFileSync(main, source.replace(windowsBinary, JSON.stringify(codex)));
