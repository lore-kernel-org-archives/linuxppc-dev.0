Message-Id: <A3E34B558F5CD211B4980008C7A4A99002423F1B@sparrow.eng.gilbarco.com>
From: "Banks, Kelly" <kelly.banks@marconi.com>
To: "'Kirk Haderlie'" <khaderlie@vividimage.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Programming Flash
Date: Wed, 13 Sep 2000 09:35:35 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There isn't necessarily ANY onboard code required to program FLASH, other
than the BDM/JTAG drivers onchip directly from Motorola.

The basics of FLASH programming consists of writing command words into
command addresses and then writing the data into the desired address
(re:AMD's Am29DL16xC pub#21553 Rev. C 08/23/99)...  I don't see why one
couldn't use MaCraigor's scripting language within the BDM Commander to
carry out the entire operation THROUGH the BDM/JTAG keeping all the logic
over on the host with no bootstrap code & no secondary ports required (Of
Course, the specifics of your FLASH device may vary).

Kelly

-----Original Message-----
From: Kirk Haderlie [mailto:khaderlie@vividimage.com]
Sent: Tuesday, September 12, 2000 4:05 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Programming Flash



We have a FADS 823 board and a MPC823 custom board on the way.  The question
is: Using the Macrgraigor flash programmer can we program blank flash, or
does some sort of boot strap need to be run in order to configure the on
board memory to use the flash programmer?  How do you program in production
with soldered down flash?  I realize this is a general embedded question.

Kirk Haderlie
kirk@vividimage.com
Vivid Image Engineering


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
