Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ACA816E.71E4FA67@mvista.com>
Date: Tue, 03 Apr 2001 22:05:34 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wang Yong <wung_y@263.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb load address and KERNELLOAD
References: <GEEHLABKDEENGODIMGHAGEFGCAAA.wung_y@263.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wang Yong wrote:
>
> Hi, all:
>   I am debugging embedded Linux( linux-2.2.13 for MPC8XX) using bdm/wiggler. I do this
> on windowsNT with cygwin and insight downloaded from www.ocdemon.com.


Don't waste your time.  It will only work for the first few instructions.
Once the MMU is enabled, these tools won't work.

The only BDM debugger that works successfully with Linux is the
Abatron gdb/BDI2000, hosted on a Linux platform.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
