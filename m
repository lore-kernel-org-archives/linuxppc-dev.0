Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 7FDF5DDF81
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 02:19:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: XILINX SPI IP core with INTC IP core.
Date: Mon, 30 Apr 2007 09:19:38 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C016482CB@ehost011-3.exch011.intermedia.net>
In-Reply-To: <20070430153149.E5489193005B@mail57-sin.bigfish.com>
References: <406A31B117F2734987636D6CCC93EE3CB0598B@ehost011-3.exch011.intermedia.net>
	<20070430153149.E5489193005B@mail57-sin.bigfish.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Rick Moleres" <Rick.Moleres@xilinx.com>,
	"Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks a lot, Rick.

Do you happen to have also reference EDK design for Spartan-3e Starter
kit which has SPI core in it?

Thanks,

Leonid.

-----Original Message-----
From: Rick Moleres [mailto:Rick.Moleres@xilinx.com]=20
Sent: Monday, April 30, 2007 8:32 AM
To: Leonid; Grant Likely; linuxppc-embedded@ozlabs.org
Subject: RE: XILINX SPI IP core with INTC IP core.


Leonid,

Here's one that we've used (tested with Wind River's 2.6.14 and MV's
2.6.10 distributions).

-Rick


-----Original Message-----
From: Leonid [mailto:Leonid@a-k-a.net]=20
Sent: Friday, April 27, 2007 7:54 PM
To: Grant Likely; linuxppc-embedded@ozlabs.org
Cc: Rick Moleres
Subject: XILINX SPI IP core with INTC IP core.

Hi,

I'm trying to use SPI and INTC IP cores together. Does somebody have
adapter.c for SPI core, using interrupts?

Thanks,

Leonid.
