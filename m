Return-Path: <wd@denx.de>
To: Ryan Wilkins <ryan@elevated-networks.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 24 Oct 2004 18:31:37 EDT."
	<77988B3D-260C-11D9-BA35-0050E4B0DC64@elevated-networks.com>
Date: Mon, 25 Oct 2004 01:39:55 +0200
Sender: wd@denx.de
Message-Id: <20041024234000.EADA1C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.com
Subject: Re: MPC850 and GDB help 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <77988B3D-260C-11D9-BA35-0050E4B0DC64@elevated-networks.com> you wrote:
> Ahh yes.. I wanted to get u-boot loaded into RAM and running from 
> there.  The reason being, I'm having a bit of a hard time writing a 
> flash chip definition file in the MPCBDM Flash.def format for the Intel 
> DA28F320J5 flash chip.  My thought was to boot u-boot from ram and then 
> see if it had better luck at detecting my flash chip and then try to 
> coerce it into writing u-boot to flash for me.

This is the wrong approach. First understand the problem, and fix it.
You will need exavctly this understanding to be able to port U-Boot.

You MUST go step by step. You cannot leapfrog problems.

> As for the "running Linux from ram" thing it was another fleeting 
> thought.  Something along the lines of if I can't get u-boot to run 
> from ram maybe I could get Linux to boot from ram and then go from 
> there.

No, that would even be trying to jump over more than one problem, and
is all the more bound to fail.

> Answer me this if you would.. Does the MPC850 have some sort eeprom or 
> parameter RAM on-chip that would be remembered in the event of a hard 
> reset or power cycle and preclude the chip from booting from flash if 
> certain registers were changed?

No. There is no information kept in the MPC8xx processor itself after
power-cycling it.  But  depending  on  your  hardware  there  may  be
features like an EEPROM with VPD or programmable BCSR's or even plain
old jumpers.

> I'm looking through the manual for the 850 now but don't see anything 
> jumping out at me.

Check the documentation for your _board_. If you have  it,  that  is.
[And  if  you  don't,  then either give up now or plan for a _lot_ of
frustrating experience.]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Boykottiert Microsoft - Kauft Eure Fenster bei OBI!
