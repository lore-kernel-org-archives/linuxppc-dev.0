Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 04 Dec 2003 10:38:00 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Re: RAMDISK Segv
In-reply-to: <3FCE5347.2070808@catapult.com>
To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3FCE57B8.1080508@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <3FCE5347.2070808@catapult.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We had such problem with busybox and it was related to the buffer
allocation policy (in busybox). We changed allocation policy from
"Allocate with stack" to "Allocate with .bss" and problem gone.

Dimitry

> Hello,
>
> I am using the RAM disk supplied by DENX on
> an 8275 FADS board.  The kernel boots and
> the RAM disk is loaded.  busybox starts
> and then I get segv's.  Any idea as to
> what is happening ?
>
> BusyBox v0.60.1 (2002.10.24-02:29+0000) Built-in shell (msh)
> Enter 'help' for a list of built-in commands.
>
> # ls /
> SIGSEGV
> #
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
