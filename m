Message-ID: <001701c295e1$eab1db60$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "Chris Hallinan" <clh@net1plus.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <NEBBKJPFOLJNBMFNKBIIKELODCAA.clh@net1plus.com>
Subject: Re: Serial Debugging
Date: Wed, 27 Nov 2002 12:25:05 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Chris

Below is the output of the command line gdb. I am using Hardhat Linux.  I
gave the command "ppc_405-gdb"

GNU gdb 5.1
Copyright 2001 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as
"--host=i686-pc-linux-gnu --target=powerpc-hardhat-linux".
(gdb)

Thanking you in advance
Regards
Aman


----- Original Message -----
From: "Chris Hallinan" <clh@net1plus.com>
To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, November 27, 2002 1:18 AM
Subject: RE: Serial Debugging


>
> Aman wrote:
> >
> > Hi All
> >
> > I am using PPC 440GP eval board. I wanted to do debug
> > application using
> > serial. The serial device /dev/ttyS0 is used as console.
> > I have connected a
> > null modem cable to the device /dev/ttyS1 on the eval kit
> > and the linux
> > host. I gv the following command in the evalkit.
> >
> > root@192.168.13.246:~# gdbserver /dev/ttyS1 hello
> > Process hello created; pid = 95
> > Remote debugging using /dev/ttyS1
> >
> > on the giving the following command in ddd window in the
> > linux host. I get
> > the following errors.
> >
> > (gdb) target remote /dev/ttyS1
> > Ignoring packet error, continuing...
> > Ignoring packet error, continuing...
> > Ignoring packet error, continuing...
> > Couldn't establish connection to remote target
> > Malformed response to offset query, timeout
> >
> >
> > Can anybody tell me , what I am missing out
>
> Is it possible you are using the native gdb, rather than the one
> compiled for your cross-development environment?  This is a common
> error in this case.
>
> Please post the output from gdb when you invoke your gdb from the
> command line.
>
> Chris Hallinan
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
