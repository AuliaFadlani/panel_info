![dfsdf](https://cloud.githubusercontent.com/assets/22923154/19686999/49d07dda-9af6-11e6-8c62-c2663392cd4d.jpg)

Source code file "uPanelInfo.pas" ini bisa dimodifikasi secara bebas sesuai dengan keperluan Anda.
Jika terjadi sesuatu dengan project Anda setelah menggunakan file "uPanelInfo.pas" bukanlah tanggung jawab Saya, 
resiko ditanggung sendiri.

cara membuat panel menjadi segitiga dan ujungnya menjadi bundar Saya lupa darimana sumbernya, rasanya dari swissdelphicenter...
Terima kasih buat yang membagi koding tersebut.

how to use:

    1. add "uPanelInfo.pas" into your project

    2. create a global variable:
       var
         pInfo: TPanelInfo;

    3. "create object"
       procedure TForm1.FormCreate(Sender: TObject);
       begin
         pInfo := TPanelInfo.Create(Self);
       end;

    4. "show the panel info"
       pInfo.Show(Sender, 'Minimal 3 Karakter', 'BOTTOM', 5)
       or
       pInfo.Show(Edit1, 'The text you want to show', 'TOP', 10)

    5. "hide the panel info"
       pInfo.hide;

    6. "remove object"
       procedure TForm1.FormDestroy(Sender: TObject; var Action: TCloseAction);
       begin
         pInfo.Destroy;
       end;

    video:
      https://www.youtube.com/watch?v=_E-E3rBEetU
      
