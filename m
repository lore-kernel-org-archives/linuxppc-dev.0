From: linuxppcdev@qbjnet.com
Date: 26 Mar 2004 10:32:04 -0600
Message-ID: <20040326163204.7277.qmail@kunk.qbjnet.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 7248 PreP VGA_CONSOLE not working in 2.6.5-rc2
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Perhaps it requires a boot time arg now however it worked in 2.6.0
without a boot arg. Maybe someone can clue me in?

dmesg line for 2.6.0:
Console: colour VGA+ 80x25

dmesg for 2.6.5-rc2 shows the dummy console and results in a blank screen.

Out of curiosity, I tried the VGA_16 framebuffer as well and it is detected
vga16fb: initializing
vga16fb: mapped to 0xf00a0000
fb0: VGA16 VGA frame buffer device
Console: switching to colour frame buffer device 80x30

But it results in a distorted version of the original POWERPC power on
graphic.

Bob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
