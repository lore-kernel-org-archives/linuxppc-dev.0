To: "Walser, Martin" <mwalser@harris.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unable to uncompess kernel image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Feb 2002 09:56:34 EST."
             <8D4C69676E66D511A1CB00508BBBB1921BCEF9@ranmx1.ran.harris.com>
Date: Tue, 05 Feb 2002 17:00:04 +0100
Message-Id: <20020205160009.43BAC116B8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8D4C69676E66D511A1CB00508BBBB1921BCEF9@ranmx1.ran.harris.com> you wrote:
>
> I've successfully developed a kernel which mounts over nfs.
> Now I want to make a zImage.initrd. To do so, I've first made a ramdisk.image.gz
> and copied it to /arch/ppc/mbxboot.
> Then I made make zImage.initrd.

OK. This is the traditional way to do it, using the bootstrap  loader
code in the mbxboot directory.

> After that, I've used mkimage to encapsulate /arch/ppc/mbxboot/zvmlinux.initrd
> to boot it with ppcboot.

Wrong. It does not work this way with PPCBoot.

See the README file that comes with PPCBoot for a description what to
do.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I used to be indecisive, now I'm not sure.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
