Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <39F4BB39.8C0F3238@snmc.com>
Date: Mon, 23 Oct 2000 17:27:05 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: clark@esteem.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Talking to the parrallel i/o ports
References: <5.0.0.25.1.20001023142754.00a40ac0@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Conn,

I wrote a nice little I/O control subsystem for the MPC850.  It is in
QSLinux (http://qslinux.org, ftp::/qslinux.org), and is in the
subdirectories snmc/qslinux/kernel and snmc/qspin.

The subsystem gives you the ability to check, request, and configure the
function of the I/O pins on the MPC850.  It is modeled after the I/O
address allocator for the 80x86 architecture.  You can access the
subsystem either from kernel space, or from a user space program.

You will need to modify the subsystem for operation with other MPC8xx
processor (i.e. the MPC860 has more I/O pins). But this should not be
difficult.

I don't have a command-line driven program that interfaces to the
subsystem, but if you write one and are willing to share it I would love
to have a copy :-).

Regards,
Daris


clark@esteem.com wrote:
>
> Hello everyone,
>
>         I was wondering if any one has written a nice little utility to control
> the parallel i/o ports of the MPC8xx. I was hoping to be able to call it
> from other programs as well as manipulate the ports from the the command
> prompt and scripts. I thought I would check to see if anybody has already
> done it before I tried to do it my self.
>
>         Many thanks in advance,
>
>         Conn Clark
> *****************************************************************
>    If you live at home long enough, your parrents will move out.
> *****************************************************************
>
> Conn Clark
> Engineering Stooge                              clark@esteem.com
> Electronic Systems Technology Inc.              www.esteem.com
>
> Stock Ticker Symbol                             ELST
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
