Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 0E34667ACD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 07:33:32 +1100 (EST)
To: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Feb 2005 13:31:35 CST."
	<6.2.1.2.1.20050209131409.02b2b718@mail.int.acdstar.com>
Date: Wed, 09 Feb 2005 21:33:09 +0100
Sender: wd@denx.de
Message-Id: <20050209203314.78351C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 JTAG/BDM Flash Burning 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <6.2.1.2.1.20050209131409.02b2b718@mail.int.acdstar.com> you wrote:
> I'm working on a custom MPC5200 board based heavily on the IceCube design 
> from Motorola/Freescale.  We plan to use the u-boot bootloader.
> 
> I'm looking for a tool to allow us to burn u-boot into the flash memory on 
> new board (with all flash devices unprogrammed).  Ideally, I'd like 

If you consider the fact that besides fash burning you may also  want
to  have  a  working hardware debugger, you should go for a BDI2000 -
especially for Linux, when MMU support is needed.

> Both the "MPCBDM" and "bdm4gdb" projects haven't been updated for 
> years.  The BDM-Tools project is more active, but only seems to support 

Tha't mostly because they are just working  fine  for  the  class  of
devices  they  have  been  designed  for.  The  MPC5200  has  no  BDM
interface,  but  a  JTAG  based  debug  interface  for  which  it  is
impossible  to  get  the necessary specifications without an NDA - an
NDA which  prevents  any  implementation  under  GPL.  Complain  with
Freescale.

> The 5200lite "IceCube" demo board came with a Metrowerks "Wiretap" BDM 
> interface, and a Green Hills "Slingshot" BDM module, but these seems to 
> require a large (and expensive) windows based "Development environment" 

And they have no idea how do deal with virtual addresses.

> We may have to write our own JTAG based pin-wiggler, but this solution 
> tends to be extremely slow.

It may be difficult to get the required documentation from Freescale,
and then you will probably spend more money (in terms of  your  time)
than you have to pay for a working tool (BDI2000).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Clothes make the man. Naked people have little  or  no  influence  on
society.                                                 - Mark Twain
