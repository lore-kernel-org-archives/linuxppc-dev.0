Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809121343q641f4204pccf6ae110fbd6a04@mail.gmail.com>
Date: Fri, 12 Sep 2008 16:43:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Device treee syntax for expanding mpc5200 gpios
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I need to implement some more of the mpc5200's gpio capabilities.

Right now we have:
gpios = <&gpio_wkup 0 0>;
first cell is index into the bank, and second is unused.

What do we need to fully describe a mpc5200 gpio?

1) open drain: 1 enable
2) interrupt: 0 no int, 1 simple, 2 wakeup, 3 both
3) interrupt type: 0 any transition, 1 rising, 2 falling, 3 pulse

A gpio pin would then have four cells?

Or should all of this be encoded into a single cell so that the
existing two cell syntax can be preserved?

--
Jon Smirl
jonsmirl@gmail.com
