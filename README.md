<div align="left">

#  Linux-system-time-monitor

**A modern, lightweight, and professional command-line utility for Linux to track your continuous system running time, system uptime, and session details.**

[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/OS-Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

</div>

---

## 📖 Overview

`stmon` (Linux Screen Time) is a beautifully formatted CLI tool crafted for developers, system administrators, and Linux enthusiasts. It fetches deep system metrics from `/proc/uptime` to accurately calculate continuous screen time and system uptime without relying on bloated external dependencies. 

Whether you want a quick glance at your daily usage, or need a JSON output for integration into custom dashboards (like Polybar or Waybar), `stmon` has you covered.

## ✨ Key Features

-  **CLI Dashboard:** Displays vital system information with clean formatting and ANSI colors.
-  **Accurate Screen Time:** Calculates continuous system uptime using precise kernel metrics (`/proc/uptime`).
-  **JSON Support:** Built-in JSON output (`--json`) for seamless integration with other tools, scripts, or APIs.
-  **Minimalist Mode:** Provides a clean, shortened uptime string (`--short`) perfect for tmux status lines or tiling WM bars.
-  **Zero Dependencies:** Written in standard `bash`. No Python, Node.js, or external packages required.
-  **System Insights:** Instantly view the current user, active sessions, system load averages, and precise boot times.

## 🚀 Installation

You can easily install `stmon` system-wide to execute it from anywhere in your environment.

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/linux-screentime.git
cd linux-screentime
```

### 2. Run the Install Script
```bash
chmod +x install.sh
sudo ./install.sh
```
*(This will safely copy the script to `/usr/local/bin/stmon` and make it globally executable).*

**Alternative (Manual Run):**
If you prefer not to install it globally, simply run:
```bash
chmod +x stmon.sh
./stmon.sh
```

## 💻 Usage

`stmon` is designed to be intuitive. Here are the available commands:

| Command | Description |
| :--- | :--- |
| `stmon` | Displays the CLI dashboard with all system metrics. |
| `stmon --short` | Outputs only the formatted screen time string (e.g., `5d 12h 18m`). |
| `stmon --json` | Outputs all metrics in a structured JSON format. |
| `stmon --help` | Displays the help menu and available flags. |
| `stmon --version` | Displays the current script version. |

### Example Output (Dashboard)
```text
╭────────────────────────────────────────────────────────╮
│             SYSTEM SCREEN TIME & UPTIME                │
╰────────────────────────────────────────────────────────╯

  Operating System: Ubuntu 24.04 LTS
  Current User:     ubuntu
  Current Time:     2026-05-10 16:45:00
  System Boot Time: 2026-05-05 08:15:22

  Continuous Running Time (Screen Time):
  ► 5d 8h 29m 38s

  System Load:      0.15, 0.08, 0.02
  Active Sessions:  2
```

### Example Output (JSON)
```json
{
  "os": "Ubuntu 24.04 LTS",
  "current_time": "2026-05-10 16:45:00",
  "boot_time": "2026-05-05 08:15:22",
  "uptime_seconds": 462578,
  "uptime_formatted": "5d 8h 29m 38s",
  "load_average": "0.15, 0.08, 0.02",
  "active_users_count": 2,
  "current_user": "ubuntu"
}
```

## 🤝 Contributing

This tool is open-source and we welcome contributions from the Linux community! 

1. Fork this repository.
2. Create a feature branch: `git checkout -b feature/awesome-feature.`
3. Commit your changes: `git commit -m 'feat: add awesome feature'`
4. Push to the branch: `git push origin feature/awesome-feature.`
5. Open a **Pull Request**!

**Ideas for future contributions:**
- Native packaging for `apt`, `pacman`, or `dnf`.
- Idle tracking integration (Wayland/X11 monitors).
- Historical logging to `~/.config/stmon/history.json`.

## 📜 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.
