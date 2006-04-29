Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 580EB679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 10:52:33 +1000 (EST)
Date: Fri, 28 Apr 2006 17:52:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim
Message-ID: <20060429005231.GH458@smtp.west.cox.net>
References: <20060428232211.GE458@smtp.west.cox.net>
	<20060429003232.9926C353DAC@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060429003232.9926C353DAC@atlas.denx.de>
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

On Sat, Apr 29, 2006 at 02:32:32AM +0200, Wolfgang Denk wrote:
> In message <20060428232211.GE458@smtp.west.cox.net> you wrote:
> >
> > You wouldn't have the dtb combined in the kernel image, unless you have
> > the shim.   This is instead of loading a separate dtb anyhow.
> 
> Now you got me completely confused. [Maybe I should go to bed.]
> 
> Kumar wrote:
> 
> > What I envision as the way one boots for something like u-boot is one  
> > of three options:
> > 1. using an old u-boot + boot wrapper (bd_t -> wrapper -> kernel)
> > 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> > takes kernel & dtb images, updates blob and passes to kernel)
> > 3. using a u-boot that is ft aware + built in dtb.
> 
> In my understanding, 1. is with a shim; 2. is loading a separate  dtb
> (probably  as  multi-file  image), and 3. is when U-Boot provides the
> dtb. Am I missing something?

I'm suggesting that we make 2 easier.  U-Boot needs the file mkuimage'd
anyways.  Why not make it easier and make adding the dtb part of that
step instead of a seperate load?  It's still quite easy to replace if
you're testing new dtb's out.

-- 
Tom Rini
http://gate.crashing.org/~trini/
