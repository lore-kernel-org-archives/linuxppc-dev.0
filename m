Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 7E2DC67A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 01:33:29 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j2HENraV016666
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 16:23:54 +0200 (EET)
Message-ID: <42399036.3010609@intracom.gr>
Date: Thu, 17 Mar 2005 16:12:06 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
References: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: looking for a model for building CRAMFS(?)-based system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert P. J. Day wrote:
>   i'm hoping someone has an example of the following that they're
> willing to share.
> 
>   currently, the system i've built for our 850 board incorporates
> 
> 	- boot loader (sadly, not u-boot, but i'm working on it)
> 	- standard zImage.initrd.bin kernel+initrd image
> 	... mountable JFFS2 filesystem with persistent stuff ...
> 
>   obviously, with this layout, it's kind of a nuisance to update
> anything individually in the initrd portion of the system, so i'd like
> to at least experiment with a layout that has separate
> 
> 	- boot loader (ideally, u-boot)
> 	- kernel image
> 	- updateable (normally mounted read-only?) root filesystem
> 	... rest of stuff the same ...
> 
>   i'm going to start over at DENX with their docs since that seems to
> be the canonical place to get the scoop on this but, in the meantime,
> if anyone has built something like this and is willing to share, say,
> their makefile so i can see how it goes together, i'd be thrilled.
> 
>   if your example happens to *require* u-boot, well, perhaps so much
> the better since that will give me the incentive to switch. :-)

We use a scheme on NAND with redundant cramfs rootfs partitions
that also contain the proper kernel image(s).

It is u-boot specific since it depends on u-boot loading the
cramfs kernel image.

For persistent storage we use a small JFFS2 partition.

> 
>   thanks.
> 
> rday

Regards

Pantelis
