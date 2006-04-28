Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai05.cox.net (fed1rmmtai05.cox.net [68.230.241.54])
	by ozlabs.org (Postfix) with ESMTP id 4CBAB679F5
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 06:50:19 +1000 (EST)
Date: Fri, 28 Apr 2006 12:44:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim
Message-ID: <20060428194457.GA458@smtp.west.cox.net>
References: <EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
	<20060428191124.B202B353DAC@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060428191124.B202B353DAC@atlas.denx.de>
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

On Fri, Apr 28, 2006 at 09:11:24PM +0200, Wolfgang Denk wrote:
> In message <EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
> Kumar Gala wrote:
> > 
> > What I envision as the way one boots for something like u-boot is one  
> > of three options:
> > 1. using an old u-boot + boot wrapper (bd_t -> wrapper -> kernel)
> > 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> > takes kernel & dtb images, updates blob and passes to kernel)
> > 3. using a u-boot that is ft aware + built in dtb.
> > 
> > The issue is that for a given system/board you may need to support  
> > multiple or all three.  This raises the question where does the .dts  
> 
> Assuming we had 2., under which circumstances would we need 3. then?

Especially if we had mkuimage let you tack your dtb into the 'kernel'
image.

-- 
Tom Rini
http://gate.crashing.org/~trini/
