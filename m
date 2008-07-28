Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id E86D3DDFCF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 03:26:45 +1000 (EST)
Date: Mon, 28 Jul 2008 09:51:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Stephen Horton <SHorton@kodiaknetworks.com>
Subject: Re: mpc744x, Marvell mv6446x kernel guidance please
Message-ID: <20080728165108.GA22621@mag.az.mvista.com>
References: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 10:46:49PM -0500, Stephen Horton wrote:
> Hello folks,
> 
> In a current work project, I have inherited a compactPCI board that has
> an mpc7447/7448 powerpc processor as well as a Marvell system
> controller, model mv64462 (stripped down mv64460). The board has a
> somewhat working Gentoo Linux port running on it from long ago and a
> company far far away (kernel version 2.6.9 built using arch/ppc). To
> prepare for an upcoming deployment, I would like to bring the OS
> up-to-date on this board with a newer kernel (targeting Gentoo 2008),
> but I am unsure of the approach to take. I am a software developer, but
> normally do not work on kernel porting / board integration. I have
> researched the arch/ppc to arch/powerpc migration, but I'm a bit
> intimidated by the 'new' device tree symantics and other changes to the
> stream. Here are some questions:
> 
> 1.	Is it possible with the 2.6.24 (Gentoo 2008) kernel to still use
> arch/ppc for this platform architecture?  I've tried to get this to
> compile, but am having trouble with files from arch/powerpc getting
> pulled in; then I read some comments (from I believe this forum) that
> indicated that arch/ppc is not longer supposed to compile

arch/ppc is gone now.  You should spend you effort working in
arch/powerpc.

> 2.	Does anyone have example code for this platform architecture?
> Any freebees I could use for creating my device tree?

You can use prpmc2800 as an example.

> 3.	Any advice of any kind?

Its not as bad as it looks.  Just dig into it and don't give up.

Mark
