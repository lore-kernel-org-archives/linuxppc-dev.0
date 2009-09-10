Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFE71B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 03:41:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6F63DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 03:41:04 +1000 (EST)
Subject: Re: Debian on MPC8572DS
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <38a5a2d10909100801x11049cddi1799c0ed6ee44410@mail.gmail.com>
Date: Thu, 10 Sep 2009 12:40:56 -0500
Message-Id: <843BD88B-F840-497D-A962-296805AEEBB7@kernel.crashing.org>
References: <38a5a2d10909100801x11049cddi1799c0ed6ee44410@mail.gmail.com>
To: Isaac Gomez Morales <isaac.gomez.morales@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do you have floating point emulation turned on in the kernel?

- k

On Sep 10, 2009, at 10:01 AM, Isaac Gomez Morales wrote:

> Hello,
>
> I'm trying to get a Linux distro such as Debian in the following  
> system
>
> System:
> mpc8572ds HW
> u-boot programmed on flash memory
> vanillia linux installed on sata disk
>
> Restrictions:
> i have not apt-get resident on system
>
>
> I have tried the following ways with no succeful results:
>
> I tried to run deboostrap with chroot on mpc8572ds
>
> I tried to run deboostrap on another machine, downloading the  
> correct packages for ppc enviroment and copiny those packages in a  
> new ext2 partition of my 8572 hw. After that i executed "chroot /mnt/ 
> newpartition /bin/bash" and it returned "Illegal instruction". At  
> this point i can't follow the installation and if i force to startup  
> the machine with that rf system, it returns a "kernel panic" with  
> error to handling the signal 4 of init process.
>
> I tried to get start the machine with a debain livecd installation.  
> I created an uImage and initrd from cdrom's vmlinux and initrd.gz  
> with the uboot-mkimage tool, then i booted it from u-boot but the  
> kernel didn't start.
>
> I tried to start a preinstalled Debian for a simillar architecture,  
> in cocnret from a mpc8561 ppc's Debian. I put its hhdd with the  
> Debian rfs on my machine and start it with my uImage and dtb files.  
> The results was the same "kernel panic" and signal 4 error.
>
>
>
> I accept all ideas.
>
> Thanks you all and sorry for my english
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
