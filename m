Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 12 Aug 2004 07:47:53 -0500
From: "Cordes, Aaron M" <aaron.m.cordes@lmco.com>
Subject: Linux 2.4.27-pre6-bk hangs on MPC8540 board
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <EE7CAF713952AC4A970DD7CD8B4C12A042DCA7@emss09m06.us.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are bringing up an 8540-based board, and are getting hangs at random
spots when booting Linux.  Sometimes the hangs occur while the kernel is
initializing, sometimes the boot gets far enough where I can log in and
run a couple of programs.  Eventually the board locks up with no oopses
or panics.  If I connect to the board with a debugger, the processor is
usually stopped in the Data miss exception handler, and there is usually
memory corruption in the kernel code.

I ran memory tests using both Edink and U-boot and they all passed, so
I'm reluctant to blame hardware for the memory corruption.  Has anyone
seen similar behavior, or have any suggestions of things I might try?

Thanks in advance
Aaron Cordes

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
