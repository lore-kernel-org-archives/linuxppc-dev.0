Return-Path: <ryan@elevated-networks.com>
In-Reply-To: <20041024215018.26468.qmail@web13802.mail.yahoo.com>
References: <20041024215018.26468.qmail@web13802.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <77988B3D-260C-11D9-BA35-0050E4B0DC64@elevated-networks.com>
From: Ryan Wilkins <ryan@elevated-networks.com>
Date: Sun, 24 Oct 2004 18:31:37 -0400
To: Frank <frannk_m1@yahoo.com>
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

Ahh yes.. I wanted to get u-boot loaded into RAM and running from 
there.  The reason being, I'm having a bit of a hard time writing a 
flash chip definition file in the MPCBDM Flash.def format for the Intel 
DA28F320J5 flash chip.  My thought was to boot u-boot from ram and then 
see if it had better luck at detecting my flash chip and then try to 
coerce it into writing u-boot to flash for me.

As for the "running Linux from ram" thing it was another fleeting 
thought.  Something along the lines of if I can't get u-boot to run 
from ram maybe I could get Linux to boot from ram and then go from 
there.

Anyway, as you can tell I'm in way over my head but I'll figure 
something out.  I've got a bit of raw programming experience with 8-bit 
micros but nothing 32-bit.  I hate to have this MPC850 sitting here 
doing nothing.

Answer me this if you would.. Does the MPC850 have some sort eeprom or 
parameter RAM on-chip that would be remembered in the event of a hard 
reset or power cycle and preclude the chip from booting from flash if 
certain registers were changed?
I'm looking through the manual for the 850 now but don't see anything 
jumping out at me.

On Oct 24, 2004, at 5:50 PM, Frank wrote:

> I think I may have confused you a little. When I said running
> u-boot from ram, I meant booting it from ram as if it had boot
> from flash. Normally, at some point, u-boot _will_ run from ram
> by copying itslef there and continung to run. But getting it to
> run from ram it's reset vector (first linked address + 0x100) is
> totally different.
> I'm not sure what you mean by "running Linux from ram". Although
> the kernel may reside in flash, it is at some point unzipped,
> copied to ram and then runs from there. Someone on this list may
> be able to help you more here. Maybe you will have beteer luck
> then me getting an answer from these guys. They don't seem to
> respond to my questions.:-(
