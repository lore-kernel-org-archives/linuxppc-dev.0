Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id 778AA67A81
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 21:14:19 +1000 (EST)
Message-ID: <4251217A.5040507@jonmasters.org>
Date: Mon, 04 Apr 2005 12:14:02 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050404081932.B8CD7C108D@atlas.denx.de>
In-Reply-To: <20050404081932.B8CD7C108D@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [Fwd: Re: Platform bus/ppc sys model - [Fwd: bi_recs and u-boot
 ppcboot.h]]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:

> In message <4250ED79.6010304@jonmasters.org> you wrote:
> 
>>| The CPCI405 supports switching the boot-cs between its 2 flash chips with the
>>| DIP-switch 4. You could copy the current ppcboot version into the 2nd flash
>>| chip as a fallback (please test it once).
>>
>>Oooh. I didn't know that (don't have the schematics here :P) - cheers.

> BTW: I will attach the BDI2000 to the CPCI405 tomorrow or so, so  you
> can continue debugging in our virtual lab, too.

Good. I'll work with the Freescale guys to get somewhere with the OF 
stuff - I know you're not so keen on this as the final solution, and I 
agree with you, but it looks like there might be sufficient critical 
mass here to finally do something about ppc boot records.

>>FWIW Stefan, I am just setting up a similar power cycler setup to what
>>you guys have there - found a cheap supplier of wireless 13A mains
>>socket automation kits (<15EUR) in the local electronics store,
>>butchered remote control unit, sufficient for a cheapo cycler.

> Can you please send me some more details?

I bought one of these yesterday:

http://www.maplin.co.uk/Module.aspx?ModuleNo=-10523&TabID=1&source=15&WorldID=&doy=4m4

The remote control is trivially butchered and the buttons replaced with 
NPN transistors running off a PIC16F628 (well it will be by tonight). 
I've got a MAX233 doing RS232 to a PC for another project so am just 
reusing the comms to allow remote on/off control of 4-16 devices.

Jon.
