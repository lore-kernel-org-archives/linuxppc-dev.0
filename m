Message-ID: <3AC23B01.A9162C3B@matrox.com>
Date: Wed, 28 Mar 2001 14:26:57 -0500
From: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
MIME-Version: 1.0
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Stability of MontaVista's 2.4.0-test2-1.2.2-1
References: <H00002af04b2e173@MHS>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Did anyone have stability problem with MontaVista's kernel
2.4.0=test2-1.2.2-1 ???  I'm running  it on a board similar to Sandpoint
with a 7400 processor and sometimes it crashes because "current->mm ==
NULL" (from do_page_fault).

I'm not using any initrd but a shell (ash) instead.  This seems to
happen when I run a lot of programs in my script.  I also seems to be
related to a synchronisation problem since it gets a lot more stable
when I add "printk"s in the functions switch_mm and activate_mm.

This could also be related to the fact that I'm running in little-endian
but since it only crashes once in a while, I would doubt it!  So I'm a
bit suspicious about this test kernel, did anybody else have problems
with it??

Sébas..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
