Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 1E4C367A81
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 18:19:48 +1000 (EST)
To: Jon Masters <jonathan@jonmasters.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 04 Apr 2005 08:32:09 BST."
	<4250ED79.6010304@jonmasters.org>
Date: Mon, 04 Apr 2005 10:19:27 +0200
Sender: wd@denx.de
Message-Id: <20050404081932.B8CD7C108D@atlas.denx.de>
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

In message <4250ED79.6010304@jonmasters.org> you wrote:
>
> | The CPCI405 supports switching the boot-cs between its 2 flash chips with the
> | DIP-switch 4. You could copy the current ppcboot version into the 2nd flash
> | chip as a fallback (please test it once).
> 
> Oooh. I didn't know that (don't have the schematics here :P) - cheers.

BTW: I will attach the BDI2000 to the CPCI405 tomorrow or so, so  you
can continue debugging in our virtual lab, too.

> FWIW Stefan, I am just setting up a similar power cycler setup to what
> you guys have there - found a cheap supplier of wireless 13A mains
> socket automation kits (<15EUR) in the local electronics store,
> butchered remote control unit, sufficient for a cheapo cycler.

Can you please send me some more details?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are certain things men must do to remain men.
	-- Kirk, "The Ultimate Computer", stardate 4929.4
