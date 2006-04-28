Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 7E4E0679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 09:22:13 +1000 (EST)
Date: Fri, 28 Apr 2006 16:22:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim
Message-ID: <20060428232211.GE458@smtp.west.cox.net>
References: <20060428194457.GA458@smtp.west.cox.net>
	<20060428230720.7C0CB353DAC@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060428230720.7C0CB353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 29, 2006 at 01:07:20AM +0200, Wolfgang Denk wrote:
> Dear Tom,
> 
> in message <20060428194457.GA458@smtp.west.cox.net> you wrote:
> >
> > > > 3. using a u-boot that is ft aware + built in dtb.
> ...
> > > Assuming we had 2., under which circumstances would we need 3. then?
> > 
> > Especially if we had mkuimage let you tack your dtb into the 'kernel'
> > image.
> 
> Sorry, but I don't understand. If we have the dtb combined  with  the
> kernel  image,  then  why would we need another copy of the dtb built
> into U-Boot?

You wouldn't have the dtb combined in the kernel image, unless you have
the shim.   This is instead of loading a separate dtb anyhow.

-- 
Tom Rini
http://gate.crashing.org/~trini/
