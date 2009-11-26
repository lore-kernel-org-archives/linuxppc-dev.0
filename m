Return-Path: <albert_herranz@yahoo.es>
Received: from smtp105.mail.ukl.yahoo.com (smtp105.mail.ukl.yahoo.com
	[77.238.184.37]) by ozlabs.org (Postfix) with SMTP id 159EAB7BDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 10:02:21 +1100 (EST)
Message-ID: <4B0F08FA.10709@yahoo.es>
Date: Fri, 27 Nov 2009 00:02:18 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop>
	<927C3343-380D-40F7-A52E-8F842A5F4C3E@kernel.crashing.org>
In-Reply-To: <927C3343-380D-40F7-A52E-8F842A5F4C3E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> So what is at d0000000 ?
> 
> 0c000000 is the flipper-compatible stuff
> 0d000000 is the hollywood new devices
> 0d800000 is the same as part of 0d000000, but with some extra bits
> sometimes.
> 

Also, when in Wii native mode, stuff like EXI, SI and AI (which is flipper-compatible stuff too) is available at 0d000000 only.

>>>> +        serial@0d006400 {
>>>> +            compatible = "nintendo,hollywood-serial";
>>>
>>> You might want to pick a more descriptive name for this,
>>> "serial" is usually understaood to mean "RS232".  Which
>>> this isn't.
>>
>> What is it then ? You definitely want some other name if it's not
>> classic rs232 style serial.
> 
> It's SPI I think, with some extra signals.  It's the gamepads mostly.
> 

EXI is SPI.
But SI is a different thingy.

See http://www.int03.co.uk/crema/hardware/gamecube/gc-control.htm .

> 
> Segher
> 
> 

Cheers,
Albert
