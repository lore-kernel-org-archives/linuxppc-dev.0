Return-Path: <bcook@bpointsys.com>
Received: from smtp111.sbc.mail.mud.yahoo.com (smtp111.sbc.mail.mud.yahoo.com
	[68.142.198.210]) by ozlabs.org (Postfix) with SMTP id 9BFE267A79
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 13:06:57 +1100 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: make install on ppc
Date: Sun, 26 Mar 2006 19:56:40 -0600
References: <OF06763F9B.91995CDB-ON4825713E.000850DE-4825713E.000949FE@cn.ibm.com>
In-Reply-To: <OF06763F9B.91995CDB-ON4825713E.000850DE-4825713E.000949FE@cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200603261956.40700.bcook@bpointsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 26 March 2006 19:42, Jin Qi Huang wrote:
> I also think the 'make install' is very useful, now on ia32, the 'make
> install' provided by the latest kernel linux-2.6.16 not only create
> initrd, copy vmlinuz and System.map to /boot directory, but also update
> grub, ppc32 does not provide this useful feature, maybe it is a pity!
>

Maybe narrow it to define 'make install' for new world/old world Macintoshes, 
or IBM machines? I can't see a generic make install being useful for the 
wider range of platforms that fall under ppc.

'make install' appears to me to be very platform dependent. Sure, on x86, you 
can reasonably assume that the majority of systems have the kernel on a disk 
under /boot and the bootloader is grub or lilo. I have 5 ppc machines 
currently, and no two use the same bootloader or kernel image. I've seen 
u-boot, yaboot, quik, powerboot (Motorola/Force), xmon (XES) and more, and 
they all required different post-processing to the kernel image to boot. For 
most of these, there is no way to programmatically guess where a particular 
kernel image should go to work with the boot loader.

 - Brent
