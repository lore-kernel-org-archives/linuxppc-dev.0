Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030113021509.36487.qmail@web41214.mail.yahoo.com>
Date: Sun, 12 Jan 2003 18:15:09 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Re: Smallest Initrd (ram disk)
To: jpotter@dualg4.com
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3E0B88CA.1FB4AC55@wvi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I downloaded both the ramdisks. I would appreciate, if
you can tell me what should i have as the value for
"root=", in Kernel Command Line. Mine shows as
"Linux/PPC load: console=ttyS0,19200 console=tty1
ip=off root=/dev/part rw".

And also, if i select the baud rate 19200, do i have
to change anything in the linux code other than
initial configuration file (defconfig).

Thanks,
Prakash


--- Jim Potter <jrp@wvi.com> wrote:
>
> Check out Wolfgang Denk's example ramdisk images at:
>
>
ftp.denx.de/pub/LinuxPPC/usr/src/mini-2048kB-ramdisk.image.gz
>
ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.image.gz
>
> > Hi folks,
> >
> > If i want to build a smallest possible initrd, can
> you
> > suggest where i can get it from or how i can build
> it?
> > I am working with a custom made PPC405 based board
> > with just 8MB RAM.
> >
> > thanks,
> > Prakash
>
> --
> Sincerely,
>
> Jim Potter
> 45th Parallel Processing
>
>   Firefighting: Bustin' ours, Savin' yours.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
