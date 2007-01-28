Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 99877DE1A3
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 06:23:41 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 28 Jan 2007 20:23:31 +0100
To: Brad Boyer <flar@allandria.com>
Subject: Re: Mac devices on PREP
Message-ID: <20070128192331.GA17989@iram.es>
References: <20070128120126.GA21984@wavehammer.waldi.eu.org>
	<20070127222403.GA24831@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070127222403.GA24831@cynthia.pants.nu>
Cc: linuxppc-dev@ozlabs.org, debian-kernel@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 27, 2007 at 02:24:03PM -0800, Brad Boyer wrote:
> On Sun, Jan 28, 2007 at 01:01:26PM +0100, Bastian Blank wrote:
> > Currently, the whole bunch of macintosh devices (drivers/macintosh) are
> > listed to be available on all ppc variants. Some of them does not build
> > for prep.
> > 
> > The attached patch restricts the whole bunch to PPC_PMAC. I'm not sure
> > if this is the correct fix.
> 
> I don't know if it still works, but there used to be support for
> ADB on CHRP hardware. I don't have any such hardware to check, so
> someone else will have to comment on that. This is one reason I
> suggested moving ADB out of drivers/macintosh, but at the time
> there was disagreement on that and I never finished the patch I
> was work on anyway.
> 
> Perhaps it should be (PPC_PMAC || PPC_CHRP || MAC) instead as a
> simple fix to prevent it from building on prep.
> 

I don't know what the situation is now, but I'm almost certain that,
once upon a time it was possible to build a kernel that would boot 
on Mac, CHRP and PReP. To be precise, it was the same kernel image
included in different boot wrappers.

	Gabriel
