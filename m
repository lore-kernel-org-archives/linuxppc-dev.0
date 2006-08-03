Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060803202557.28DED35360F@atlas.denx.de>
References: <20060803202557.28DED35360F@atlas.denx.de>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 15:40:21 -0500
Message-Id: <1154637621.5094.60.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 22:25 +0200, Wolfgang Denk wrote:
> In message <1154636438.5094.45.camel@localhost> you wrote:
> > 
> > However, currently the zImage has an elfheader which will come before
> 
> May it have whatever it wants. It's irrelevant.
> 
> WE DO NOT USE zImage FILES FOR U-BOOT.

I've explained this well enough at this point, if you don't want to ask
more questions to figure it out then I can not really help anymore.

> 
> > > This way U-Boot will load (and if necessary  uncompress)  the  kernel
> > > image plus your attached bootstrap code to it's normal start address.
> > > Then  it starts your bootstrap code which can fixup DTB and then just
> > > start the kernel.
> > > 
> > 
> > We do not need to worry about this with cuImage because the kernel
> > section will not be compressed. If compression is desired it will be
> > done at the U-Boot level (were U-Boot would do the uncompressing).
> 
> Yes,  we  do  need  to  care  about  this.  A  useless  copy  of  the
> uncompressed  kernel  image  is  just  a  waste  of boot time. Not to
> mention that you have to copy your bootstrapo loader out of  the  way
> before it gets overwritten.

I agree. Your previous advice is something I am going to try to reduce
memory copying. Keeping the bootloader after the kernel image should
prevent any overwritting problems, as you said.

-Matthew
