using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Diagnostics;

[InitializeOnLoad]
public class Autorun {
  static Autorun() {
    UnityEngine.Debug.Log("Here");
    Process proc = new Process();
    proc.EnableRaisingEvents = false;
    proc.StartInfo.FileName = Application.dataPath + "/../src/build.sh";
    proc.StartInfo.WorkingDirectory = Application.dataPath + "/../src";
    proc.StartInfo.Arguments = "";
    proc.StartInfo.UseShellExecute = false;
    proc.StartInfo.CreateNoWindow = true;
    proc.StartInfo.RedirectStandardOutput = true;
    proc.StartInfo.RedirectStandardError = true;
    proc.OutputDataReceived += new DataReceivedEventHandler(DataReceived);
    proc.ErrorDataReceived += new DataReceivedEventHandler(ErrorReceived);
    // proc.Start();
    // proc.BeginOutputReadLine();
    // proc.BeginErrorReadLine();
    // UnityEngine.Debug.Log("Started!");
    // proc.WaitForExit();
    UnityEngine.Debug.Log("Done! " + proc.ExitCode);
  }

  static void DataReceived(object sender, DataReceivedEventArgs eventArgs) {
    UnityEngine.Debug.Log(eventArgs.Data);
  }

  static void ErrorReceived(object sender, DataReceivedEventArgs eventArgs) {
    UnityEngine.Debug.LogError(eventArgs.Data);
  }
}
