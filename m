Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCF21@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: segmentation fault when using "signal"
Date: Mon, 22 Apr 2002 01:04:58 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've a probelm using the signal function.
I'm using Kernel 2.4.4 from Denx. When I install a signalhandler for SIGCHLD, I
get an segmentation fault, when the child process is finished.

I've found out that this happens, when the function installed by signal returns.

Any ideas?

regards
Martin"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
