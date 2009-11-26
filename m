Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B811B7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:43:58 +1100 (EST)
In-Reply-To: <1259211061.16367.260.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <927C3343-380D-40F7-A52E-8F842A5F4C3E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
Date: Thu, 26 Nov 2009 23:50:53 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> BTW. If we want to play with clocks, maybe you should look at
> my proposed binding for clocks and implementing the clk API :-)

There are no clocks that are configurable from the PowerPC side
(well, maybe things like the USB clocks, but we do not know how).

>>> +		/* Team Twiizers' 'mini' firmware IPC */
>>> +		mini@0d000000 {
>>
>> Although mini is awesome, it isn't hardware, and doesn't
>> belong in the device tree.
>
> So what is at d0000000 ?

0c000000 is the flipper-compatible stuff
0d000000 is the hollywood new devices
0d800000 is the same as part of 0d000000, but with some extra bits
sometimes.

>>> +		serial@0d006400 {
>>> +			compatible = "nintendo,hollywood-serial";
>>
>> You might want to pick a more descriptive name for this,
>> "serial" is usually understaood to mean "RS232".  Which
>> this isn't.
>
> What is it then ? You definitely want some other name if it's not
> classic rs232 style serial.

It's SPI I think, with some extra signals.  It's the gamepads mostly.


Segher
