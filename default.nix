{ pkgs ? import <nixpkgs> {} }:
let
  extensions = (with pkgs.vscode-extensions; [
      vscodevim.vim
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "lean";
      publisher = "jroesch";
      version = "0.16.29";
      sha256 = "sha256-CWvBK3agaR04cyBqnV7JIbRWA31vf0++HonbFnfPjpE=";
    }
  ];
  vscodium-with-extensions = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = extensions;
  };
in
{
  shell = pkgs.mkShell {
    buildInputs = with pkgs; [
      elan
      mathlibtools
      vscodium-with-extensions
    ];
  };
}
