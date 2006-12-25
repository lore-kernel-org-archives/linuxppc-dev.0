Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5BDF5DDEEE
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Dec 2006 07:31:21 +1100 (EST)
Date: Mon, 25 Dec 2006 21:31:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
Subject: Re: Linux 2.6.20-rc2: forgot how to make a zImage on powerpc?
In-Reply-To: <45902A6F.4000100@glines.org>
Message-ID: <Pine.LNX.4.60.0612252128530.3424@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 25 Dec 2006, Mark Glines wrote:

> Mark Glines wrote:
> > Hmm.  I'm trying to build 2.6.20-rc2 on a little powerpc box with
> > arch/powerpc/configs/linkstation_defconfig, and I get:
> ...
> >   MODPOST vmlinux
> > ln: accessing `arch/powerpc/boot/zImage': No such file or directory
> > make[1]: *** [arch/powerpc/boot/zImage] Error 1
> > make: *** [zImage] Error 2
> > 
> > So, uh, are we forgetting to go into the right subdirectory to make the
> > actual zImage, or what?  If I'm just doing something wrong, I'd love to know
> > what it is.
> > 
> > I'll follow up here on lkml if I diagnose this further.  Thanks,
> 
> 
> Followup:  Yeah, it looks like it just doesn't know which format of zImage to
> produce for linkstation.
> 
> I'm not sure what image should be used by default.  I guess it depends on the
> bootloader.  Maybe default to uImage, as uBoot seems to be fairly common on
> these devices?

Yes, uImage is the format used on linkstation. Is there a way to cleanly 
specify this in the kernel sources apart from a comment in Kconfig?

Thanks
Guennadi
---
Guennadi Liakhovetski
