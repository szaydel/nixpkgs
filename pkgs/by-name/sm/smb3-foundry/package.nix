{
  lib,
  stdenv,
  fetchFromGitHub,
  python3,
}:

let
  python = python3.withPackages (
    ps: with ps; [
      pyside6
      py65
      qdarkstyle
    ]
  );

in
stdenv.mkDerivation (finalAttrs: {
  pname = "smb3-foundry";
  version = "1.4";

  src = fetchFromGitHub {
    owner = "mchlnix";
    repo = "SMB3-Foundry";
    tag = finalAttrs.version;
    hash = "sha256-9pztxzgdPqrTNUMtD9boxtqb32LCsGMoa/bBq5GSJ1I=";
  };

  buildInputs = [ python ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/smb3-foundry $out/bin
    cp -r smb3parse foundry scribe data doc VERSION smb3-foundry.py smb3-scribe.py $out/share/smb3-foundry

    ln -s $out/share/smb3-foundry/smb3-foundry.py $out/bin/smb3-foundry
    ln -s $out/share/smb3-foundry/smb3-scribe.py $out/bin/smb3-scribe

    runHook postInstall
  '';

  meta = {
    changelog = "https://github.com/mchlnix/SMB3-Foundry/releases/tag/${finalAttrs.src.tag}";
    description = "Modern Super Mario Bros. 3 Level Editor";
    homepage = "https://github.com/mchlnix/SMB3-Foundry";
    license = lib.licenses.gpl3Only;
    mainProgram = "smb3-foundry";
    maintainers = with lib.maintainers; [ tomasajt ];
    platforms = lib.platforms.unix;
  };
})
