Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "mallikarjuna raju" <malli_arjuna@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: porting linux on to mpc8250 processor
Date: Sat, 27 Dec 2003 10:33:13 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW14-F82zWJLdaEgDk0003f90f@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
can u suggest me how to start with porting linux on to mpc8250
the host system i am using is i386 processor with redhat 9 linux running on
it,
and the porting on to mpc8250 as target system.
some body has suggested me to first go for developing a toolchain setup.
can any one suggest me how to proceed for this as this tool chain should be
a host /target development toolchain, with some cross compilers etc.

please help me out in this regards

bye mallikarjuna.


>From: Wolfgang Denk <wd@denx.de>
>To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
>CC: linuxppc-embedded@lists.linuxppc.org
>Subject: Re: Boot Loader Date: Mon, 22 Dec 2003 14:08:53 +0100
>
>
>Dear Kevin,
>
>in message <3FE6DCB3.109@catapult.com> you wrote:
> >
> > For my end target I have to boot across a shared memory
> > interface by placing the executable into RAM.  This is
> > part of a multi processor system where the Linux board
> > is a cPCI slave.  The Linux board will not have a flash
> > or a network connection.  I is held in reset by the master
> > until the s/w is loaded and then released.  This is an 8275
>
>This has been done before. See for example the  "PN62"  configuration
>in U-Boot.
>
> > Any suggestions on how to do this ?
>
>Use U-Boot...
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>It all seemed, he thought, to be rather a lot of  trouble  to  go  to
>just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_
>
>

_________________________________________________________________
Murphy's Laws. They are crazy and funny.
http://server1.msn.co.in/features/murphy/index.asp Buy the complete book
online now!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
