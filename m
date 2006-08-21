Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 154C467C05
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 06:39:10 +1000 (EST)
Date: Mon, 21 Aug 2006 13:43:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Bryan O'Donoghue <bodonoghue@codehermit.ie>
Subject: Re: [PATCH] Add adder87x board support to 2.6.x
Message-ID: <20060821204320.GD16290@mag.az.mvista.com>
References: <20060820203649.4dbf89a6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060820203649.4dbf89a6@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Aug 20, 2006 at 08:36:49PM +0100, Bryan O'Donoghue wrote:
> Greetings all.
> 
> This set of patches adds support for the Analogue & Micro Adder87x to Linux.
> 
> The port is based on mpc885ads in the 2.6.18-rc4 tree.
> The patches are very simple really consisting of a stripped down version of
> mpc885ads renamed to adder87x*blah, a defconfig and appropriate entries in 
> arch/ppc/Kconfig, arch/ppc/platforms/Makefile and include/asm-ppc/mpc8xx.h.
> 
> I've spent a bit of time testing this out, and I'm reasonably happy that this
> should be useful to others using this development board.
> 
> 
> Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>

Bryan,

If you're not already on the linuxppc-dev mailing list, you should be.
The 'ppc' tree is deprecated and all new work should be happening in the
'powerpc' tree (as in arch/powerpc).

The odds of this being accepted are slim but either way, you should read
the mail archive and get involved in the powerpc migration.

Mark
