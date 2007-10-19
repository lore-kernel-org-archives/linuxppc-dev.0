Return-Path: <dgibson@ozlabs.org>
Date: Fri, 19 Oct 2007 11:46:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alan Bennett <embedded@akb.net>
Subject: Re: Freescale Interrupt enabling
Message-ID: <20071019014610.GE30283@localhost.localdomain>
References: <bfa0697f0710180741i5063ad94ga13086bf3c43a511@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfa0697f0710180741i5063ad94ga13086bf3c43a511@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 08:41:35AM -0600, Alan Bennett wrote:
> We were developing with Linux 2.6.10 and a Planetcore boot loader,
> however, recent work has us up and running with 2.6.23+ and U-boot
> 1.2.0.  However, we are now running into a few challenges regarding
> the differences.
> 
> Our driver writer's code isn't functioning, but it was with 2.6.10 and
> planet core.  The best I can tell is that the default interrupt
> controller configuration isn't where it was in the planetcore/2.6.10
> version.
> 
> for example, let's look at enabling timer1 / interrupt number 12
> 
> simple description.
> 	       timer1 {
> 	 	       name = "timer1";
>  		       compatible = "fsl,mpc8248_timer";
> 		       interrupts = <c 8>;
> 		       interrupt-parent = <&PIC>;

Device tree nodes should really describe an actual device, not just
some random floating interrupt.  You need to work out what device this
interrupt actually belongs to, and describe that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
