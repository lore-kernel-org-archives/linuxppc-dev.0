Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 4D5D667DEF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 01:11:05 +1000 (EST)
To: "David Grab" <d.grab@hima.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 29 Jul 2005 10:32:01 +0200."
	<001f01c59417$fe81b840$f201a8c0@SN7606>
Date: Fri, 29 Jul 2005 17:10:40 +0200
Sender: wd@denx.de
Message-Id: <20050729151040.9DE58352BD9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ATI Radeon with PPC 440 GX and kernel 2.6.12 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <001f01c59417$fe81b840$f201a8c0@SN7606> you wrote:
> 
> i´m using on my custom board a ATI M6 Mobility Radeon with kernel 2.6.12.
> Now i have to initialize the ati and configure the kernel to support it. Did
> someone use this combination (ppc + ati radeon)? It would be appreciating to
> get some help or tipps in configuring to get the ati functioning. Especially
> the BIOS of the ATI chip, because i have actually found only x86 binaries.
> Is it also possible to set up the bios settings for the ati chip without an
> bios eeprom attached via the radeon driver?

If you use U-Boot as boot loader you  can  enable  and  use  the  x86
emulator  taht  comes included with it. But don't expect to much help
with that - except for the Amiga  One  (where  I  was  told  this  is
working) I don't know of any other board using this feature.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Two wrongs don't make a right, but three rights make a left.
