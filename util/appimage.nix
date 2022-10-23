{ pkgs, ... }:

{
  appimagePackage = { binName, version, url, sha256, meta ? { platforms = [ "x86_64-linux" ]; } }:
    let
      pname = "${binName}-appimage";
      name = "${pname}-${version}";

      src = pkgs.fetchurl {
        inherit url sha256;
        name = "${name}.AppImage";
      };

      appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
    in pkgs.appimageTools.wrapType2 {
      inherit name src meta;

      extraInstallCommands = ''
        mv $out/bin/${name} $out/bin/${binName}
        install -m 444 -D ${appimageContents}/*.desktop $out/share/applications/${binName}.desktop
        sed -i 's/Exec=.*/Exec=${binName}/g' $out/share/applications/${binName}.desktop
      '';
    };
}
