Attribute VB_Name = "vtkFileSystemUtilities"
'---------------------------------------------------------------------------------------
' Module    : vtkFileSystemUtilities
' Author    : Lucas Vitorino
' Purpose   : Provide some utilities for interacting with files and folders.
'               - creation
'               - existence
'               - reading
'               - deletion...
'---------------------------------------------------------------------------------------

'---------------------------------------------------------------------------------------
' Procedure : vtkCreateFileInDirectory
' Author    : Abdelfattah Lahbib
' Date      : 30/04/2013
' Purpose   : Create a file named $fileName in the directory $directory
' Notes     : Notably used for creating Git log files
'---------------------------------------------------------------------------------------
'
Public Function vtkCreateFileInDirectory(fileName As String, directory As String) As String

    Dim fso As New FileSystemObject
    Dim fullFilePath As String
      
On Error GoTo vtkCreateFileInDirectory_Error
    
    fullFilePath = directory & "\" & fileName
      
    ' If the file doesn't exist, we create it
    If fso.FileExists(fullFilePath) = False Then
            fso.CreateTextFile (fullFilePath)
    End If
      
    'return full created file path
    vtkCreateFileInDirectory = fullFilePath

    On Error GoTo 0
    Exit Function

vtkCreateFileInDirectory_Error:
    MsgBox "Error " & err.Number & " (" & err.Description & ") in procedure vtkCreateFileInDirectory of Module vtkGitFunctions"
    vtkCreateFileInDirectory = err.Number

End Function

'---------------------------------------------------------------------------------------
' Procedure : vtkTextFileReader
' Author    : Abdelfattah Lahbib
' Date      : 30/04/2013
' Purpose   : Returns the content of a text file
' Notes     : Notably used to read Git log files.
'---------------------------------------------------------------------------------------
'
Public Function vtkTextFileReader(fullFilePath As String) As String

    Dim Textfile As Variant
    Dim strresult As String
    Dim fso As New FileSystemObject

On Error GoTo vtkTextFileReader_Error

    Set Textfile = fso.OpenTextFile(fullFilePath, ForReading)
    'while not end of file
    Do Until Textfile.AtEndOfStream
    'read line per line
        strresult = strresult & Chr(10) & Textfile.ReadLine
    Loop
    'return file text
    vtkTextFileReader = strresult

   On Error GoTo 0
   Exit Function

vtkTextFileReader_Error:
    MsgBox "Error " & err.Number & " (" & err.Description & ") in procedure VtkTextFileReader of Module vtkGitFunctions"
    vtkTextFileReader = err.Number
    
End Function


'---------------------------------------------------------------------------------------
' Function  : vtkCreateTreeFolder
' Author    : Jean-Pierre Imbert
' Date      : 06/08/2013
' Purpose   : Create a project folder breakdown into the folder given as parameter
'             This procedure is isolated to be easier to test
' Return    : Long error number
'---------------------------------------------------------------------------------------
'
Public Function vtkCreateTreeFolder(rootPath As String)
   On Error GoTo vtkCreateTreeFolder_Error
    ' Create main folder
    MkDir rootPath
    ' Create Delivery folder
    MkDir rootPath & "\" & "Delivery"
    ' Create Project folder
    MkDir rootPath & "\" & "Project"
    ' Create Tests folder
    MkDir rootPath & "\" & "Tests"
    ' Create GitLog Folder
    MkDir rootPath & "\" & "GitLog"
    ' Create Source folder
    MkDir rootPath & "\" & "Source"
    ' Create ConfProd folder
    MkDir rootPath & "\" & "Source" & "\" & "ConfProd"
    ' Create ConfTest folder
    MkDir rootPath & "\" & "Source" & "\" & "ConfTest"
    ' Create VbaUnit folder
    MkDir rootPath & "\" & "Source" & "\" & "VbaUnit"

   On Error GoTo 0
   vtkCreateTreeFolder = 0
   Exit Function
vtkCreateTreeFolder_Error:
    vtkCreateTreeFolder = err.Number
End Function

'---------------------------------------------------------------------------------------
' Procedure : vtkDeleteTreeFolder
' Author    : Jean-Pierre Imbert
' Date      : 06/08/2013
' Purpose   : Delete a project folder breakdown given as parameter
'             This procedure is for test purpose
'---------------------------------------------------------------------------------------
'
Public Sub vtkDeleteTreeFolder(rootPath As String)
    Dir (rootPath)                  ' Make sure to be out of the folder to clean it without Err
    On Error Resume Next
    Kill rootPath & "\Source\ConfProd\*"
    RmDir rootPath & "\Source\ConfProd"
    Kill rootPath & "\Source\ConfTest\*"
    RmDir rootPath & "\Source\ConfTest"
    Kill rootPath & "\Source\VbaUnit\*"
    RmDir rootPath & "\Source\VbaUnit"
    Kill rootPath & "\GitLog\*"
    RmDir rootPath & "\GitLog"
    Kill rootPath & "\Tests\*"
    RmDir rootPath & "\Tests"
    Kill rootPath & "\Source\*"
    RmDir rootPath & "\Source"
    Kill rootPath & "\Delivery\*"
    RmDir rootPath & "\Delivery"
    Kill rootPath & "\Project\*"
    RmDir rootPath & "\Project"
    Kill rootPath & "\*"
    RmDir rootPath
End Sub



