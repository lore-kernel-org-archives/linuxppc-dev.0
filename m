Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <406B9D084FAFD4118C980008C79FADB901B57FF4@ALBMAIL>
From: "Yang, Bo" <bo.yang@transcore.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: serial console lost when linux kernel boots up
Date: Fri, 11 Apr 2003 13:49:54 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to run linux kernel (Linux version 2.4.4 downloaded from DENX)
on MPC8XXFADS (CPU:860T) board. The root file system is mounted via NFS.
The root file system I used is the one coming with DENX's ELDK package (I
use ELDK cross compile tools).

The problem is that once the linux kernel boots up I lose serial
console(e.g. no loggin prompt). There is one warning message as the last
printout on my console terminal:
"Warning: unable to open an initial console". I look at the root file system
on my host linux box and found out that there is no device file populated
under "opt/eldk/ppc_8xx/dev".
I wonder the root file system I used may not be a complete file system. Any
ideas? Thanks for any hints.

Bo Yang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
