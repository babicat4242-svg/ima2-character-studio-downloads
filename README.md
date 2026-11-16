# IMA2 Character Studio

## macOS (experimental community installer)

This release is officially distributed for Windows. An experimental macOS installer is available in [macos/install.sh](macos/install.sh). It downloads the official 0.1.4 Windows release, checks its SHA-256 digest, and adapts its Electron app locally; application source is not included in this repository. This is not an official macOS release and image generation has not yet been verified end to end.

Requirements: macOS, Node.js 22 or newer, npm, and a working macOS `codex` CLI on your PATH. From a checkout of this repository, run:

```sh
bash macos/install.sh
```

Then open `~/Applications/HERA-Character-Mac/HERA 시작.command`. The app uses its own Codex login and stores its library under `~/Library/Application Support/IMA2 Character Studio`. Its Codex app-server communicates over standard input/output; it does not provide a web URL. The installer refuses to overwrite an existing installation. It has been smoke-tested on Apple Silicon; Intel Macs and login/image generation remain unverified.

[Windows 설치 파일 다운로드](https://github.com/babicat4242-svg/ima2-character-studio-downloads/releases/latest)

Windows 10/11 64비트용 캐릭터 시트 앱입니다. 설치 파일만 다운로드하면 됩니다. Node.js, Git, Codex 별도 설치는 필요 없습니다.

1. 설치 파일을 실행하면 시작 메뉴와 바탕 화면에 바로가기가 생성됩니다.
2. 앱의 **ChatGPT 로그인**을 눌러 공식 로그인 페이지에서 본인 계정을 연결합니다.
3. 같은 인물의 사진을 1~3장 선택하고 (한 장만으로도 가능), A/B/C 구성, 체형, 남자/여자/원본 의상 핏을 선택합니다.
4. **캐릭터 시트 만들기**를 누르면 완성된 이미지가 보관함에 자동 저장됩니다.
5. 보관함에서 다시 열기, 설정 재사용, PNG 저장, 삭제가 가능합니다.

A안: 얼굴 3컷 + 전신 4컷. B안: 힉스필드용 3컷(정면 목 아래·후면 전신·얼굴). C안: 성인 체형 확인 7컷, 넓은 어깨끈 흰색 나시와 짧은 기본복, 맨발.
모델 체형을 고르면 얼굴은 유지하고 체형 비율만 조정합니다. 체형은 이미지·모델·아이돌 세 가지이며 기본은 이미지 체형입니다. 통통하거나 뚱뚱한 체형도 이미지 체형에서는 그대로 유지합니다.

본인의 Codex 사용 가능 계정과 사용 한도가 필요합니다. 이미지 생성은 Codex 사용량에 포함되며 별도 API 키를 입력하지 않습니다. 생성 결과와 세부 패널 비율은 AI 결과에 따라 달라질 수 있습니다.
사진과 보관함은 이 컴퓨터의 앱 데이터에 저장됩니다. 생성할 때 선택한 참조 사진과 요청이 OpenAI에 전달됩니다. 별도의 IMA2 서버로 사진을 전송하지 않습니다. 다른 컴퓨터와 자동 동기화하지 않습니다.
이 앱은 독립적으로 제작되었으며 OpenAI 공식 앱이 아닙니다.

이 초기 배포본의 설치 파일에는 코드 서명이 없습니다.

모델·아이돌 체형은 원본 ima2-gen 등록 프리셋을 사용합니다. 모델 8.5~9등신, 아이돌 7.5~8등신이며 남녀별 설정을 유지합니다.
