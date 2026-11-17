# 🔥 SnapStreak – Verilog HDL Project

<p align="center">

**A Snapchat-Inspired Digital Streak Tracker Using Verilog HDL**

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue?style=for-the-badge&logo=amd)
![Simulation](https://img.shields.io/badge/Simulation-Icarus%20Verilog-green?style=for-the-badge)
![Waveform](https://img.shields.io/badge/Waveform-GTKWave-purple?style=for-the-badge)
![Verification](https://img.shields.io/badge/Tests-11%2F11%20PASS-brightgreen?style=for-the-badge)

</p>

---

## 📌 Project Overview

Ever wondered what happens behind Snapchat streaks?

This project implements a simplified Snapchat-inspired streak tracking system using **Verilog HDL**.

The design tracks incoming snap events, increments the streak counter, monitors elapsed clock cycles, and automatically resets the streak when the timeout condition is reached.

The complete design is simulated and verified using Icarus Verilog, with waveform analysis in GTKWave.

**Note:** The 24-hour timeout concept is represented using 5 clock cycles in this simulation to make testing faster.

## ⚙️ How It Works

1. **Initial State:** The system waits for the first snap.
2. **First Snap:** The streak counter becomes 1.
3. **Next Snap:** The streak counter increments by 1.
4. **Timer:** Counts elapsed clock cycles between snaps.
5. **Timeout:** If no snap arrives within the configured timeout, the streak resets to 0.
6. **New Streak:** A new snap starts another streak.

## 🧠 Digital Concepts Used

| Concept | Application |
|---|---|
| FSM | Controls IDLE and ACTIVE states |
| Counter | Tracks consecutive snaps |
| Timer | Measures elapsed clock cycles |
| Sequential Logic | Updates registers on clock edges |
| Conditional Logic | Handles snap and timeout events |
| Testbench | Verifies expected behaviour |
| Waveform Analysis | Observes internal signal transitions |

## 🏗️ Design Architecture

```text
          SNAP EVENT
               |
               v
       +---------------+
       |   FSM CONTROL |
       +---------------+
               |
        +------+------+
        |             |
        v             v
  STREAK COUNTER  TIMER COUNTER
        |             |
        |             v
        |       TIMEOUT CHECK
        |             |
        +------+------+
               |
               v
        STREAK OUTPUT
               |
        RESET ON TIMEOUT
```

## 🛠️ Tools & Technologies

- **Verilog HDL** – RTL design
- **Icarus Verilog** – Compilation and simulation
- **GTKWave** – Waveform visualization
- **VS Code** – Code editing
- **MSYS2 UCRT64** – Windows terminal environment

## 📂 Project Structure

```text
SnapStreak-Verilog/
│
├── snap_streak.v
├── snap_streak_tb.v
├── snap_streak.vcd
│
├── GTKWave waveform.png
├── PASS terminal output..png
│
└── README.md
```

## 🚀 Run the Project

### Step 1: Clone Repository

```bash
git clone https://github.com/narasimha-01/SnapStreak-Verilog.git
```

### Step 2: Navigate to Project

```bash
cd SnapStreak-Verilog
```

### Step 3: Compile Verilog Files

```bash
iverilog -g2012 -Wall -s snap_streak_tb -o snap_streak.out snap_streak.v snap_streak_tb.v
```

### Step 4: Run Simulation

```bash
vvp snap_streak.out
```

### Step 5: Open GTKWave

```bash
gtkwave snap_streak.vcd
```

## 📊 Simulation Results

### 1. GTKWave – Timing Diagram

The waveform demonstrates:

- Clock signal transitions
- Snap event detection
- Streak counter increment
- Timer counter progression
- Timeout detection
- Automatic streak reset

![GTKWave Timing Waveform](./GTKWave%20waveform..png)

### 2. Testbench Verification Report

The testbench checks 11 scenarios, including reset, snap detection, counter increments, timeout, and recovery.

<details>
<summary><b>Verification Test Cases</b></summary>

| Test | Expected Behaviour |
|---|---|
| Reset initialization | Streak = 0 |
| First snap | Streak = 1 |
| Second snap | Streak = 2 |
| Timer increment | Timer increases |
| Timeout | Streak resets |
| Expired pulse | One clock cycle |
| New streak | Counter restarts |
| Active reset | System resets correctly |

</details>

![Terminal Verification Report](./PASS%20terminal%20output..png)

<details>
<summary><b>Simulation Summary</b></summary>

```text
SNAPSTREAK VERIFICATION START

PASSED : 11
FAILED : 0

RESULT: ALL TESTS PASSED
```

</details>

## 🎯 What I Learned

Through this project, I explored:

- How real-world application behaviour can be represented using digital logic.
- How to design a finite state machine in Verilog.
- How counters and timers work in sequential circuits.
- How to write a Verilog testbench.
- How to verify RTL behaviour using simulation.
- How to analyze timing waveforms using GTKWave.

## 🔮 Future Improvements

- Configurable timeout duration.
- Multiple streak event scenarios.
- Enhanced FSM architecture.
- FPGA-based hardware implementation.
- Seven-segment display for streak count.

## 👨‍💻 Author

**Narasimha Lakkimsetty**

ECE Student | VLSI & Digital Design Enthusiast

- GitHub: [@narasimha-01](https://github.com/narasimha-01)
- Instagram: [@narasimhalakkimsetty](https://instagram.com/narasimhalakkimsetty)

---

<p align="center">

**Learn • Build • Simulate • Verify**

*Turning everyday technology into digital logic projects.*

</p>
