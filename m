Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99532DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 11:36:09 +1100 (EST)
Date: Fri, 29 Feb 2008 19:36:35 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080301003610.99532DDE19@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 05:51 PM 2/29/2008, you wrote:
>On Fri, 29 Feb 2008 17:31:10 -0500
>Steve Heflin <sheflin@newagemicro.com> wrote:
>
> > At 04:35 PM 2/29/2008, Josh Boyer wrote:
> > >On Fri, 29 Feb 2008 16:34:09 -0500
> > >Steve Heflin <sheflin@newagemicro.com> wrote:
> > >
> > > > I attempted to enable the kernel debugger on my Sequoia board, and I
> > > > get build errors:
> > > >   /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:254: undefined
> > > > reference to `set_debug_traps'
> > > >   /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:259: undefined
> > > > reference to `breakpoint'
> > > >
> > > > Josh: I assume you have used the kernel debugger with your 44x
> > > > boards, how did you build it?
> > >
> > >Why would you assume that?  I've never used kgdb on arch/powerpc
> > >kernels, nor have I ever tried to build it.
> >
> > I assumed that because I've always needed a debugger when
> > implementing kernel level components. Since you've implemented kernel
> > level support for several 44x processors, I just assumed that you
> > needed kdbg at some point. So you're saying that your additions
>
>Nope.  I did the poor man's method of manually poking characters out of
>the serial port.
>
> > worked right out of the gate and you never needed a 
> debugger?  You're my hero!
>
>I largely stood on the shoulders of those that came before me.  Porting
>has become trivial lately, mostly due to the collective work lots of
>people have put in.
>
>That all being said, I'm not opposed to having kgdb work on 4xx.  I
>just have never personally looked at it yet.  Patches welcome :).
>
>josh

poor man's debugging works fine if a serial port is available, but my 
Sequoia platform doesn't get that far!  I use u-boot to download and 
boot my image, and I don't get any serial output after the boot completes:

=> bootm 0x500000
## Booting image at 00500000 ...
    Image Name:   Kernel and Ramdisk
    Created:      2008-03-01   0:09:57 UTC
    Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
    Data Size:    2430248 Bytes =  2.3 MB
    Load Address: 00000000
    Entry Point:  00000000
    Contents:
    Image 0:  1471523 Bytes =  1.4 MB
    Image 1:   958712 Bytes = 936.2 kB
    Verifying Checksum ... OK
    Uncompressing Multi-File Image ... OK
    Loading Ramdisk to 07e42000, end 07f2c0f8 ... OK
------
console port is now dead.
------
