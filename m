Return-Path: <richw@netcomuk.co.uk>
Received: from xsmtp08.mail2web.com (xsmtp08.mail2web.com [168.144.250.208])
	by ozlabs.org (Postfix) with ESMTP id 2B692DE042
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 22:14:54 +1000 (EST)
Received: from [168.144.108.6] (helo=M2W006.mail2web.com)
	by xsmtp08.mail2web.com with smtp (Exim 4.63)
	(envelope-from <richw@netcomuk.co.uk>) id 1KV3HQ-00024c-En
	for linuxppc-dev@ozlabs.org; Mon, 18 Aug 2008 07:52:13 -0400
Message-ID: <380-220088118115212377@M2W006.mail2web.com>
From: "richw@netcomuk.co.uk" <richw@netcomuk.co.uk>
To: linuxppc-dev@ozlabs.org
Date: Mon, 18 Aug 2008 07:52:12 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: Clock / Timebase / Bus Frequencies Help
Reply-To: richw@netcomuk.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We've got an 8347 based board very similar to the A&M asp8347=2E Core cloc=
k
is 400MHz=2E Bus clock is 266666666Hz=2E
According to the data sheet for the 8347, the decrementer clock runs at a
quarter of the rate of the bus clock=2E I have two questions:
In arch/powerpc/boot/redboot-83xx=2Ec, the timebase clock is passed to
dt=5Ffixup=5Fcpu=5Fclocks() as bi=5Fbusfreq / 16=2E If I leave it like thi=
s, my
system clock runs approximately 4 times too fast=2E=20
Can anyone point me in the direction of an explanation for the div by 16
rather than 4=3F

If I change the call to dt=5Ffixup=5Fcpu=5Fclocks so that bi=5Fbusfreq/4 i=
s passed
in, then the clock runs more accurately=2E However, its still not correct=2E=

This gives a decrementer frequency of 66666666Hz, but if I hard code the
value to 66000000Hz, the clock runs accurately=2E
Can anyone shed any light on why the value passed in by the boot loader
(redboot) seems to be inaccurate=2E

Cheers,


Richard=2E



--------------------------------------------------------------------
mail2web LIVE =96 Free email based on Microsoft=AE Exchange technology -
http://link=2Email2web=2Ecom/LIVE
