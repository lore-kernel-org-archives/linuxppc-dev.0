Return-Path: <dgibson@ozlabs.org>
Date: Mon, 15 Sep 2008 12:40:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Device treee syntax for expanding mpc5200 gpios
Message-ID: <20080915024048.GA20312@yookeroo.seuss>
References: <9e4733910809121343q641f4204pccf6ae110fbd6a04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910809121343q641f4204pccf6ae110fbd6a04@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2008 at 04:43:22PM -0400, Jon Smirl wrote:
> I need to implement some more of the mpc5200's gpio capabilities.
> 
> Right now we have:
> gpios = <&gpio_wkup 0 0>;
> first cell is index into the bank, and second is unused.
> 
> What do we need to fully describe a mpc5200 gpio?
> 
> 1) open drain: 1 enable
> 2) interrupt: 0 no int, 1 simple, 2 wakeup, 3 both
> 3) interrupt type: 0 any transition, 1 rising, 2 falling, 3 pulse

Maybe I'm misunderstanding the situation, but 2 and maybe 3 look more
like configuration than something inherent to the hardware setup.
Couldn't different drivers potentially choose different interrupt
modes depending on their needs?  Remember the device tree describes
the hardware, not how it's used.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
