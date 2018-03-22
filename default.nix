# let
#   origPkgs = import <nixpkgs> {};
#   overPkgs = origPkgs.overrideAttrs (x:
#     {lmdb = origPkgs.lmdb.overrideAttrs (old: { doCheck = true; }); });
# in
  # opts = {nixpkgsFunc = x: import <nixpkgs> x; };
  # opts = {nixpkgsFunc = x: import ../reflex-platform/nixpkgs x; };

let
  opts = {config = {packageOverrides = pkgs: {
    lmdb = pkgs.lmdb.overrideAttrs (old: { doCheck = false; });};};};
in
(import ../../reflex-platform-3 {}).project ({ pkgs, ... }: {
  packages = {
    # common = ./.;
    common = builtins.filterSource (p: t: true
      && baseNameOf p != ".git"
      && baseNameOf p != ".stack-work"
      && baseNameOf p != ".ideaHaskellLib"
      && baseNameOf p != "db"
      && baseNameOf p != "db.test"
      && baseNameOf p != "db.specs"
      && baseNameOf p != "bin"
      && baseNameOf p != "exp-xml"
      && baseNameOf p != "dist-newstyle"
      ) ./.;
    # backend = ./backend;
    # frontend = ./frontend;
  };

  overrides = self: super: with pkgs.haskell.lib; {
    # reflex-dom-core = dontHaddock (dontCheck (self.callCabal2nix "reflex-dom-core"
    #   ./reflex-dom/reflex-dom-core {}));
    gi-javascriptcore = self.callHackage "gi-javascriptcore" "3.0.14" {};
  };
  #   # compose-ltr = pkgs.haskell.lib.dontCheck (self.callHackage "compose-ltr" "0.2.4" {});
  #   # compose-ltr = self.callHackage "compose-ltr" "0.2.4" {};
  #   #     Encountered missing dependencies:
  #   # gi-javascriptcore ==3.0.*
  #   gi-javascriptcore = self.callHackage "gi-javascriptcore" "3.0.14" {};
  #   # neat-interpolation = self.callHackage "neat-interpolation" "0.2.3" {};
  #   compose-ltr = dontCheck (super.compose-ltr);
  #   reflex-dom-core = dontCheck (super.reflex-dom-core);
  #   # hs-di = dontHaddock (dontCheck super.hs-di);
  #   minilens = doJailbreak (super.minilens);
  #   # lmdb = pkgs.haskell.lib.dontCheck (super.lmdb);
  #   lmdb =
  #     dontCheck (
  #     # (pkgs.lib.trivial.flip addBuildTool) "lmdb" (
  #     # (pkgs.lib.trivial.flip addExtraLibrary) "lmdb" (
  #     # (pkgs.lib.trivial.flip addExtraLibrary) pkgs.lmdb (
  #     # # (pkgs.lib.trivial.flip addExtraLibrary) pkgs.gitg (
  #     # (pkgs.lib.trivial.flip addBuildDepend) "gitg" (
  #     # (pkgs.lib.trivial.flip addBuildDepend) "lmdb" (
  #     # (pkgs.lib.trivial.flip addPkgconfigDepend) "lmdb" (
  #     # (pkgs.lib.trivial.flip addSetupDepend) "lmdb" (

  #     let a = super.lmdb; in
  #       # trace (attrNames a)
  #       a
  #     # )
  #     # )
  #     # )
  #     # )
  #     # )
  #     );

  #   # jsaddle = self.callCabal2nix "jsaddle" (pkgs.fetchFromGitHub {
  #   #   owner = "ghcjs";
  #   #   repo = "jsaddle";
  #   #   rev = "fb9ba5a036efc8ebe9b528391c21c6880ce2e4c6";
  #   #   sha256 = "0bwm1l9hjq6crgxl24i8i8my1y593g2yhbd6qa4hb5nddmh5wg47";
  #   # }) {
  #   #   postUnpack = "sourceRoot+=/jsaddle; echo source root reset to $sourceRoot";
  #   # };

  #   jsaddle-warp = dontCheck (self.callCabal2nix "jsaddle-warp" "${pkgs.fetchFromGitHub {
  #     owner = "ghcjs";
  #     repo = "jsaddle";
  #     rev = "fb9ba5a036efc8ebe9b528391c21c6880ce2e4c6";
  #     sha256 = "0bwm1l9hjq6crgxl24i8i8my1y593g2yhbd6qa4hb5nddmh5wg47";
  #   }}/jsaddle-warp" {});

  #   jsaddle = dontCheck (self.callCabal2nix "jsaddle" "${pkgs.fetchFromGitHub {
  #     owner = "ghcjs";
  #     repo = "jsaddle";
  #     rev = "fb9ba5a036efc8ebe9b528391c21c6880ce2e4c6";
  #     sha256 = "0bwm1l9hjq6crgxl24i8i8my1y593g2yhbd6qa4hb5nddmh5wg47";
  #   }}/jsaddle" {});

  #   reflex-dom-contrib = self.callCabal2nix "reflex-dom-contrib" (pkgs.fetchFromGitHub {
  #     owner = "reflex-frp";
  #     repo = "reflex-dom-contrib";
  #     rev = "88bfbf5df196c2207e50e88e78ae9b43af4be44b";
  #     sha256 = "19hdyijjwcwnqs8sw6gn5kdb92pyb6k9q2qbrk0cjm3nd93x60wm";
  #   }) {};
  #   hs-di = dontHaddock (dontCheck (self.callCabal2nix "hs-di" (pkgs.fetchFromGitHub {
  #     owner = "Wizek";
  #     repo = "hs-di";
  #     rev = "166d9b640b5d241d186a3bdcd4b008774e059060";
  #     sha256 = "1vn2rclmlhg85n3ipsdc47a6nf2svpl38kh600hvsgc6zzwgagmb";
  #   }) {}));
  #   hint = dontHaddock (dontCheck (self.callCabal2nix "hs-di" /home/wizek/sandbox/hint {}));
  #   # 88bfbf5df196c2207e50e88e78ae9b43af4be44b
  # };


  shells = {
    # ghc = ["common" "backend" "frontend"];
    ghc = ["common" ];
    ghc8_2_1 = ["common" ];
    # ghcjs = ["common" "frontend"];
  };
})
