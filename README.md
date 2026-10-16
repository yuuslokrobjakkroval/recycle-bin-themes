<h1 align="center">
  <img src="assets/default-bin-icon.png" alt="Recycle Bin icon" width="80"><br>
  Windows Recycle Bin Themes
</h1>

<p align="center">
  Give your desktop a little personality with custom full and empty Recycle Bin icons.
</p>

<p align="center">
  <a href="https://github.com/yuuslokrobjakkroval">GitHub</a> &bull;
  <a href="https://www.youtube.com/@yuuslokrobjakkroval">YouTube</a> &bull;
  <a href="https://www.tiktok.com/@yuuslokrobjakkroval?lang=en">TikTok</a>
</p>

## About

Choose from seven themes and give your Recycle Bin a different look when it is empty or full. Apply icons manually or use the included PowerShell script to choose a theme and restore the default icons.

## Theme gallery

Expand a theme to see its preview and open its icon folder.

<details>
<summary><b>Patrick Star</b></summary>

<img src="themes/patrick-star/preview.gif" alt="Patrick Star Recycle Bin preview">

[View icons](themes/patrick-star)
</details>

<details>
<summary><b>Pop Cat</b></summary>

<img src="themes/pop-cat/preview.gif" alt="Pop Cat Recycle Bin preview">

[View icons](themes/pop-cat)
</details>

<details>
<summary><b>Kirby</b></summary>

<img src="themes/kirby/preview.gif" alt="Kirby Recycle Bin preview">

[View icons](themes/kirby)
</details>

<details>
<summary><b>Kanna</b></summary>

<img src="themes/kanna/preview.gif" alt="Kanna Recycle Bin preview">

[View icons](themes/kanna)
</details>

<details>
<summary><b>Sword Kirby</b></summary>

<img src="themes/sword-kirby/preview.gif" alt="Sword Kirby Recycle Bin preview">

[View icons](themes/sword-kirby)
</details>

<details>
<summary><b>French Fries</b></summary>

<img src="themes/french-fries/preview.gif" alt="French Fries Recycle Bin preview">

[View icons](themes/french-fries)
</details>

<details>
<summary><b>Minecraft Chest</b></summary>

<img src="themes/minecraft-chest/preview.gif" alt="Minecraft Chest Recycle Bin preview">

[View icons](themes/minecraft-chest)
</details>

## Getting started

Download this repository using **Code > Download ZIP**, then extract it, or clone it:

```powershell
git clone https://github.com/yuuslokrobjakkroval/recycle-bin-themes.git
cd recycle-bin-themes
```

### Option 1: Apply a theme with PowerShell

Requires Windows, PowerShell, and an internet connection to download the icons.

1. Open the extracted or cloned project folder.
2. Right-click [RecycleBinThemes.ps1](RecycleBinThemes.ps1) and select **Run with PowerShell**, or run it from PowerShell in that folder:

   ```powershell
   .\RecycleBinThemes.ps1
   ```

3. Enter the number beside your preferred theme.
4. To restore the standard Windows icons, run the script again and choose **0 (Default)**.

The script saves icons in `%USERPROFILE%\Pictures\RecycleBinThemes`, updates the current user's Recycle Bin icon registry entries, and restarts Windows Explorer to apply the change. Your taskbar and File Explorer windows may briefly disappear. Keep the downloaded icons in place while using a theme.

The script currently downloads icons from the original `sdushantha/recycle-bin-themes` repository. If PowerShell blocks script execution under your system's policy, use the manual option below.

### Option 2: Apply icons manually

1. Open a theme folder in the [themes directory](themes) and download both files ending in `-empty.ico` and `-full.ico`. Store them in a permanent folder.
2. Open **Settings > Personalization > Themes > Desktop icon settings**.
3. Select **Recycle Bin (full)**, choose **Change Icon**, and browse to the `-full.ico` file.
4. Repeat for **Recycle Bin (empty)** using the `-empty.ico` file, then select **Apply**.

If the icon does not switch correctly between empty and full, back up the registry key before making the following adjustment:

1. Open **Registry Editor** and navigate to:

   ```text
   HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon
   ```

2. For the **(Default)**, **empty**, and **full** values that point to your custom `.ico` files, append `,0` to the icon path. For example: `C:\Users\YourName\Pictures\RecycleBinThemes\pop-cat-empty.ico,0`.
3. Refresh the desktop to check the result.

To restore the Windows icons manually, return to **Desktop icon settings**, select the Recycle Bin entries, and use **Restore Default**, then **Apply**.

## Contributing

New themes are welcome!

1. Fork this repository and create a folder under `themes` using this structure:

   ```text
   themes/your-theme-name/
     your-theme-name-empty.ico
     your-theme-name-full.ico
     preview.gif
   ```

2. Add the folder name to the `$supported_themes` array in [RecycleBinThemes.ps1](RecycleBinThemes.ps1).
3. Record a preview GIF with the wallpaper color `#2d7d9a` so it matches the existing previews.
4. Add your theme to the gallery in this README.
5. If adding a theme to this fork, update the script's download URLs to the repository and branch hosting your new icons so the script can download them.
6. Open a pull request describing your theme.

## Connect with me

Follow **yuuslokrobjakkroval**:

- [GitHub](https://github.com/yuuslokrobjakkroval)
- [YouTube](https://www.youtube.com/@yuuslokrobjakkroval)
- [TikTok](https://www.tiktok.com/@yuuslokrobjakkroval?lang=en)

## Credits

- Original project and PowerShell script by [Siddharth Dushantha](https://github.com/sdushantha/recycle-bin-themes).
- Inspired by [this Reddit post](https://reddit.com/r/pcmasterrace/comments/uvtdbx/cat_bin/) by [u/DARKplayz_](https://reddit.com/user/DARKplayz_).
- Manual icon refresh workaround shared in [this Reddit comment](https://reddit.com/r/pcmasterrace/comments/uvtdbx/cat_bin/i9nn1pq/).
