# 🌍 UniLearn — Learn Your Way

A universal study companion for every kid, everywhere. **100% offline app.**

---

## ✅ Fixed: iOS build error

The `ios` folder has been removed completely, and a `codemagic.yaml` file is now included that tells Codemagic to build **only Android and Windows** — so it will never try to touch iOS again.

---

## 🚀 How to build your app with Codemagic (no commands, just clicks)

### Step 1 — Push this to GitHub
1. Unzip this folder on your computer
2. Go to github.com → create a new repository called `unilearn`
3. Upload **all the files and folders** from inside `unilearn_flutter` (not the zip itself)
4. Click "Commit changes"

### Step 2 — Connect to Codemagic
1. Go to codemagic.io → sign up with Google
2. Click "Add application" → choose GitHub → select your `unilearn` repo
3. Codemagic will detect the `codemagic.yaml` file automatically ✅

### Step 3 — Build
1. You'll see two workflows: **"UniLearn Android Build"** and **"UniLearn Windows Build"**
2. Click **Start new build** on the Android one first → wait 5-10 minutes
3. Click **Download** → you get `app-release.apk`
4. Repeat for Windows → you get your `.exe` files

### Step 4 — Install
- **Android**: send the `.apk` file to your phone (WhatsApp, email, USB) → tap it → tap "Install" (you may need to allow "install from unknown sources" once)
- **Windows**: copy the Release folder to your laptop → double click `unilearn.exe` → it opens like any other app

---

## 📱 What's inside

- Onboarding — name, age, country, Academic/Non-Academic, parent name
- Home — greeting, today's plan, subject progress
- Schedule — 7-day learn/practice/rest cycle
- Learn — all subjects, tap to start a 15-min lesson
- Lesson screen — video, experiment, safety disclaimer, "Did that make sense?" button, confetti
- Progress — streak, videos watched, attendance calendar, subject % complete
- Passport — collectable stamps for every topic learned
- 😴 Tired today button — no guilt, always visible
- 100% offline — Hive local database, no internet needed after install
