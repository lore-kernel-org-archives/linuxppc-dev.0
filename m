Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <607BF0A2B4F3D411A09500508BC225427E8339@mailctx.datum.com>
From: Geoff Wyche <GWyche@DATUM.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: timer interrupt for task switching
Date: Wed, 31 Oct 2001 09:47:38 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm having an odd problem with my prototype 860T linuxppc system.
The linux kernel boots fine, but hangs when it attempts to launch /linuxrc
If I issue a soft reset to the CPU via BDM, the processor reboots, the linux
kernel boots fine, and then launches /linuxrc with no problems.

I believe that somehow I have turned off some crucial timer interrupt that
controls process switching, which prevents the kernel from ever starting
/linuxrc

What interrupt handler triggers task switching?

Should I be concerned about these messages, printed during the boot
sequence?

Decrementer Frequency = 187500000/60
Warning: real time clock seems stuck!

The warning is printed even after the soft reset, when process switching
seems to work.

--Geoff
gwyche@datum.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
