Return-Path: <benh@kernel.crashing.org>
Subject: Re: solution to printk() blocking interrupts?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910809220645g129eba73jc952d4bb2746f5db@mail.gmail.com>
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>
	<48D77FCB.8000404@ru.mvista.com>
	<9e4733910809220645g129eba73jc952d4bb2746f5db@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 15:46:43 +1000
Message-Id: <1222148803.12085.97.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >  It's a strange piece of hardware that loses interrupts on getting overrun.
> > :-)
> 
> The 4 second pause slows down the debug/test cycle a lot. I'm using a
> net booted monolithic kernel on the hardware and using the reset
> button every time I make a change.

I'm not going to have much feelings for you here... I've debugged the
kernel on setups that need 30mn to reboot :-)

Ben.
