{ appimageTools, fetchurl }:

let
  pname = "astro-editor";
  version = "1.0.17";

  src = fetchurl {
    url = "https://github.com/dannysmith/astro-editor/releases/download/v${version}/astro-editor-latest.AppImage";
    hash = "sha256-BiIDC4OlwzckuTVt/D1XHkstaqhKl3t1TML53/OOxeY=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 \
      "${appimageContents}/Astro Editor.desktop" \
      "$out/share/applications/astro-editor.desktop"

    install -Dm444 \
      "${appimageContents}/astro-editor.png" \
      "$out/share/icons/hicolor/512x512/apps/astro-editor.png"
  '';

  meta = {
    description = "Markdown editor for Astro content collections";
    homepage = "https://astroeditor.danny.is/";
    mainProgram = "astro-editor";
    platforms = [ "x86_64-linux" ];
  };
}
