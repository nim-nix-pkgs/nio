{
  description = ''A Mini Server Framework for Nim language'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nio-master".dir   = "master";
  inputs."nio-master".owner = "nim-nix-pkgs";
  inputs."nio-master".ref   = "master";
  inputs."nio-master".repo  = "nio";
  inputs."nio-master".type  = "github";
  inputs."nio-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nio-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}