Date: Sun, 25 Nov 2001 22:39:16 -0800
Subject: MACE networking (NOT!)
From: Mark Jaffe <wizards@wizdev.net>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B8272394.E34C%wizards@wizdev.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, listas! I am engaged in a crusade to get a PowerMac 8500 with dual-604e
card online running YellowDog 2.0. I have the 2.4.10-B0a SMP kernel
installed, and am continually thwarted getting it into production due to
faulty networking.

The built-in networking refuses to work properly under Linux. I have no
problems with MacOS, it operates with either a static IP (at the Co-Lo) or
under DHCP (from an AirPort base station in the home office.) But in Linux,
DHCP gets an IP but will not make any connection, and with the static IP at
the Co-Lo it will perform for a few hours then become unreachable. Has this
issue ever been seen? Is there any way to diagnose what is going on and
resolve this problem?

Mark
============================================================
Mark Jaffe            | (408) 972-9638 (home)
Chief Wizard          | (408) 807-1530 (cell/page/voicemail)
Computer Wizards      | (425) 795-6421 (FAX)
wizards@wizdev.net    | http://www.wizdev.net/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
