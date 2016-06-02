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
      string n = ProcessFilename(i);
      if (n != null) {
        haxeFiles.Add(n);
      }
    }

    if (haxeFiles.Count > 0) {
      Rebuild(haxeFiles);
    }
  }

  static string ProcessFilename(string name) {
    if (name.StartsWith("Assets/src/") && name.EndsWith(".hx")) {
      string n = name.Substring(11,name.Length-3-11).Replace("/", ".");
      if (n.Contains(".")) {
        n = n.Substring(0, 1).ToLower() + n.Substring(1);
      }
      return n;
    }
    return null;
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
    } else {
      UnityEditor.AssetDatabase.Refresh();
    }
  }
}
