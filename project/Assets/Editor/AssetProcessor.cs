using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Diagnostics;
using System.Collections.Generic;


public class AssetProcessor : AssetPostprocessor {
	static void OnPostprocessAllAssets (string[] importedAssets,
                                      string[] deletedAssets,
                                      string[] movedAssets,
                                      string[] movedFromAssetPaths) {
    List<string> haxeFiles = new List<String>();
    foreach(var i in importedAssets) {
      if (i.StartsWith("Assets/src/") && i.EndsWith(".hx")) {
        string name = i.Substring(11,i.Length-3-11).Replace("/", ".");
        if (name.Contains(".")) {
          name = name.Substring(0, 1).ToLower() + name.Substring(1);
        }
        haxeFiles.Add(name);
      }
    }

    Rebuild(haxeFiles);
  }

  static void Rebuild(List<string> files) {
    Process proc = new Process {
      StartInfo = new ProcessStartInfo {
        FileName = Application.dataPath + "/src/build.sh",
        WorkingDirectory = Application.dataPath + "/src",
        Arguments = String.Join(" ", files.ToArray()),
        UseShellExecute = false,
        RedirectStandardOutput = true,
        RedirectStandardError = true,
      }
    };

    proc.OutputDataReceived += (sender, args) => {
      if (args.Data != null) {
        UnityEngine.Debug.Log(args.Data);
      }
    };
    proc.ErrorDataReceived += (sender, args) => {
      if (args.Data != null) {
        UnityEngine.Debug.LogError(args.Data);
      }
    };

    proc.Start();
    proc.WaitForExit();
    proc.BeginErrorReadLine();
    proc.BeginOutputReadLine();

    if (proc.ExitCode != 0) {
      UnityEngine.Debug.Log("Build failed with error code: " + proc.ExitCode);
    }
  }
}
