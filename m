To: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
Subject: Re: Linux on a 823FADS
Message-ID: <981443392.3a7fa340ef0e2@imp.imms.de>
Date: Tue, 06 Feb 2001 08:09:52 +0100 (MET)
From: Christian Schroeder <christian.schroeder@imms.de>
Cc: linuxppc-embedded@lists.linuxppc.org
References: <3A7F4C08.21F4AC7E@intel.com>
In-Reply-To: <3A7F4C08.21F4AC7E@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Quoting "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>:

>
> Hi.
>
> I've been encharged with the (ungrateful) mission of making Linux run on
> a 823FADS board. I've already got the latest version of ppcboot (0.8.1)
> up and running from Flash, but I'm struggling to get Linux to boot.
>
> How am I supposed to build the kernel? It seems the FADS port has long
> been abandoned. I'm trying to revive it, by including it back into the
> config and making necessary changes in order for the kernel to compile.
> Am I on the right track?

Hi Bruno,

I use mpc8xx-2.2.13 along with some patches from www.solutions4linux.de
on a FADS823 board (Rev. Pilot from 1997). The Board has 2 MB flash and
8 MB dram. Linux runs from flash with an initial ramdisk but you can use
a nfs-mounted root directory too. I use ppcboot 0.7.2 at the moment.

Christian


Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
www:     http://www.imms.de/~christi/cs.html
pgp:     finger christi@finger.imms.de

-------------------------------------------------
This mail sent through IMP: imp.imms.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
