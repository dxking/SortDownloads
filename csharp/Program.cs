using System;
using System.IO;

namespace sortDownloads
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = "C:\\Users\\dxkin\\Downloads";

            if(Directory.Exists(path))
            {
                ProcessDirectory(path);
            }
            else
            {
                Console.WriteLine($"{path} is not a valid file or directory.");
            }
        }

        static void ProcessDirectory (string targetDirectory)
        {
            string [] fileEntries = Directory.GetFiles(targetDirectory);
            foreach(string fileName in fileEntries)
                ProcessFile(fileName);

/*
            // process subdirectories
            string [] subdirectoryEntries = Directory.GetDirectories(targetDirectory);
            foreach(string subdirectory in subdirectoryEntries)
                ProcessDirectory(subdirectory);
*/
        }

        static void ProcessFile(string path)
        {
            // skip hidden desktop.ini file
            if(path.Contains("desktop.ini"))
            {
                Console.WriteLine($"Skipped file {path}");
            }
            else
            {
                // dir name without filename
                string parentPath = Path.GetDirectoryName(path);

                // filename without path
                string fileName = Path.GetFileName(path);

                // remove . from extension
                string extension = Path.GetExtension(path).Substring(1);
                string extensionDir = Path.Combine(parentPath, $"sorted-{extension}");

                // create sorted dir if not exists
                if(!Directory.Exists(extensionDir))
                {
                    Directory.CreateDirectory(extensionDir);
                }

                File.Move(path, Path.Combine(extensionDir, fileName), true);

                Console.WriteLine($"Processed file {path}");
            }
        }
    }
}
