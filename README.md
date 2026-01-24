# Flashlight Beamshot Comparator

A standalone, interactive web tool for comparing large amounts of flashlight beamshots. Built using vanilla HTML, CSS, and JavaScript with no external dependencies. Designed for easy embedding into static websites or platforms like WordPress.

## Included Files

### 1. main-comparator.html
The full-featured version of the tool.
* **Features:** Location selector, metadata table (Lumen, Throw, Cd/lm), image export (canvas generation), and slider comparison.
* **Usage:** Great for comparing a large catalog of beamshots, switching between locations, and creating downloadable comparison images.

### 2. compact-comparator-reviews.html
A minimalist version of the tool.
* **Features:** Comparison slider and image labels only. No metadata table, location selector, or export functions.
* **Usage:** Intended for comparing a small-ish amount of lights (e.g., Review Item vs Competitor) within a single location.
* **Note:** This script uses isolated scope and unique ID prefixes to allow co-existence with the main comparator on the same page.

### 3. Generator Scripts (*.ps1)
PowerShell scripts used to automate the generation of the JSON configuration objects.
* `script-main.ps1`: Generates configuration for the Main Comparator (prompts for Lumens [lm] and Throw [m], autofills them and calculates cd/lm).
* `script-compact-reviews.ps1`: Generates configuration for the Compact Comparator (names and URLs only).

---

## How to Add Your Beamshots

The tool relies on a list of data (names, specs, and image URLs) located inside the HTML file. You can generate this list automatically using the included scripts or write it manually.

### Step 1: Upload images to your website
Before configuring the tool, your beamshot photos must be hosted online.
1.  Upload your `.jpg/.png` images to your website (e.g. WordPress Media Library).
2.  Copy the "Base URL" where they are stored.
    * *Example:* `https://grzybekreviews.pl/wp-content/uploads/2025/12` (as it is in my website)
    * You can find this link on Wordpress, going into the gallery, selecting a recently added image and copying its link.

### Step 2: Generate the configuration code

#### Method A: Using the Script (Faster for many images)
1.  Create a folder with all the beamshots you want to add (e.g. on your desktop).
2.  Name the image files clearly (e.g., `Acebeam_L35_Turbo.jpg`). The script uses the filename as the flashlight name (names can be edited later in the code itself).
3.  Open the script (`script-main.ps1` or `script-compact-reviews.ps1`) with a notepad.
4.  Find the line `$WebUrlPrefix` and change it to your website's upload URL from Step 1.
5.  Find the link 'X' and paste in the location of your beamshots folder. Save and close.
6.  Right-click the script and select **Run with PowerShell**.
7.  Follow the prompts. The script will generate the formatted code block for you.
8.  Copy the block and go to **Step 3**.

#### Method B: Manual Entry
1.  Open the HTML file (`main-comparator.html` or `compact-comparator-reviews.html`) in a text editor.
2.  Scroll down to the JavaScript section to find `const lightData` (right under /* --- USER DATA START --- */).
3.  Edit the code or copy and paste the template below to add a new entry.

**Template for Main Comparator:**
```javascript
"unique_id_here": {
    name: "Flashlight Model Name",
    location: "loc1", // Must match a key defined in 'const locations'
    lumen: "2000",
    throw: "400",
    cdlm: "10",
    image: "[https://your-website.com/uploads/your-image.jpg](https://your-website.com/uploads/your-image.jpg)"
},
```
**Template for Compact Comparator:**
```javascript
"unique_id_here": {
    name: "Flashlight Model Name",
    image: "[https://your-website.com/uploads/your-image.jpg](https://your-website.com/uploads/your-image.jpg)"
},
```
### Step 3: Update the HTML File
1.  Take the code generated in Step 2 (either from the PowerShell window or your manual typing).
2.  Open the HTML file with a notepad.
3.  Replace/add in to the existing content inside `const lightData = { ... };` with your new code.

---

## Installation on your Website

1.  Open your edited HTML file (`main-comparator.html` or `compact-comparator-reviews.html`).
2.  Copy the entire code.
3.  Go to your website editor.
4.  Add a **Custom HTML** block (WordPress) or paste directly into your page source.
5.  Save and Publish.
