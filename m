Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id B54FBDDDB6
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 03:02:29 +1000 (EST)
Message-ID: <4A255B21.8040002@gersys.de>
Date: Tue, 02 Jun 2009 19:02:25 +0200
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: MPC52xx simple GPIO support
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi
I still don't quite understand how to use the Flattened Device Tree /
Open Firmware. I see there's a driver (mpc52xx_gpt.c) that supports to
use the Pins on the GPT as simple GPIOs. I activated it by adding these
lines to my dts file:

gpt2: timer@620 {
	compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
	reg = <0x620 0x10>;
	interrupts = <1 11 0>;
	gpio-controller;
	#gpio-cells = <2>;
};

I can see the appropriate entries in sysfs
(/sys/devices/f0000000.soc5200/f0000620.timer), but how can I actually
use these GPIO's now?

Many thanks
Stefan.
