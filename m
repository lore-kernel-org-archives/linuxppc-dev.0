Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C69349F.37B0B21C@nexus-tech.net>
Date: Tue, 12 Feb 2002 10:28:31 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc823 w/lcd performance
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Should I have reasonable performance running a MPC823 with the LCD
controller driving a 640x480 color TFT panel? The reason I ask is that I
compile the kernel with lcd823.c (pulled from Wolfgang's ftp site)
selecting the SHARP LQ64D340. The system slows to a crawl. I calculate
the LCD using 26% of bus bandwidth. But, it appears to be using much
more. I haven't actually hooked up the panel yet (waiting for cabling).

Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
