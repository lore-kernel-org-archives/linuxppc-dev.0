Return-Path: <rick.moleres@xilinx.com>
Received: from outbound1-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 680CF67BA5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 01:47:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Subject: RE: Linux on Virtex4
Date: Thu, 13 Jul 2006 09:46:55 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C0295E559@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: =?iso-8859-2?B?QWxluSBHb3Jraeg=?= <ales.gorkic@fs.uni-lj.si>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Ales,

Hmmmm...  No, I've not done anything with the Avnet MM board.  I may =
have responded to somebody who was working with that board on this list. =
 We work a lot with PLB TEMAC and MV Linux, but do very little with GSRD =
(it's a reference design that's not officially supported through the =
EDK). On the surface, I don't think I can help much here, but feel free =
to directly send me a more detailed email and maybe I can point you to =
someone who can help.

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On =
Behalf Of Ale=B9 Gorkic
Sent: Wednesday, July 12, 2006 7:13 AM
To: linuxppc-embedded@ozlabs.org
Subject: re:Linux on Virtex4

Hi Rick,

I saw on linuxppc-embedded at ozlabs.org that you are trying to port (or =
better you did) monta vista linux to Avnet's V4FX Mini-Module. I will =
try to deal with the same thing. My design is basically the same: all =
features of MM incorporated in CoreConnect style architecture. I also =
tried with Multi Port Memory Controller (MPMC2) and ported (memory =
works, but for LAN I still need phy datasheet) the Gigabit System =
Reference Design (GSRD2) to Mini-Module.
By using the MPMC2 memory core you can connect PPC directly to memory =
using two PLBs (data and instruction separated). This way you might =
solve the CPU cache errata. The problem with MPMC2 is that it consumes A =
LOT of BRAM and logic. I tried to build a full featured system, but =
V4FX12 lacks logic for the purpose.
Is there a way that you can help me with running MV linux on my system?

Cheers,


Ales Gorkic

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
