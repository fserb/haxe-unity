using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Diagnostics;

[InitializeOnLoad]
public class Autorun {
  static Autorun() {
    Rebuild();
  }

  static void Rebuild() {
    UnityEngine.Debug.Log("Autorun");
    Process proc = new Process {
      StartInfo = new ProcessStartInfo {
        FileName = Application.dataPath + "/src/build.sh",
        WorkingDirectory = Application.dataPath + "/../src",
        Arguments = "",
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
