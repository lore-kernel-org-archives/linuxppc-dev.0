Message-ID: <3974F963.81CF77E9@mvista.com>
Date: Tue, 18 Jul 2000 17:42:11 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: matthias.fuchs@esd-electronics.com
CC: frowand@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: [Re: making kernel for ppc405gp from montavista sources]
References: <3974ED19.FCD99008@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Matthias Fuchs wrote:
>
>
> Subject: making kernel for ppc405gp from montavista sources
> Date: Sat, 05 Aug 2000 18:01:56 +0200
> From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> Organization: esd gmbh
> To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
>
> Hello,
>
> I downloaded the linux_tar.gz file from montavista and unpacked it ! I
> copied the .config file from the same location to the kernel tree's
> root. Before I did a "make mrproper".
>
> When I run a "make dep" I got an error ! Well, I could start to check
> out if there is an error in the tree, but I think that there is a
> general mistake I made !
>
> Does anybody know where the error comes from ? Here is the output of my
> "make dep":
>
> ----------------------
> mfuchs@pc-matthias:~/mvista_405_linux_new/linux > make dep
> make -C arch/ppc/boot fastdep
> make[1]: Entering directory

< stuff deleted >

> make[2]: *** No rule to make target
> `/home/mfuchs/mvista_405_linux_new/linux/include/linux/autoconf.h',
> needed

< stuff deleted >

>
> thanks for advise
> Matthias
>
> --
> -------------------------------------------------
> \ Matthias Fuchs                                 \
>  \ esd electronic system design Gmbh              \
>   \ Vahrenwalder Straße 205                        \
>    \ D-30165 Hannover                               \
>     \ email: matthias.fuchs@esd-electronics.com      \
>      \ phone: +49-511-37298-0                         \
>       \ fax:   +49-511-37298-68                        \
>        --------------------------------------------------
>

Matthias,

You need to get the .config file from the MontaVista ftp site, then do a

  make oldconfig
  make dep
  then make your kernel

Let me know if that doesn't work for you.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
