Return-Path: <stelios@stelioscellar.com>
Received: from memova2.tellas.gr (memova2.tellas.gr [62.169.194.61])
	by ozlabs.org (Postfix) with ESMTP id E9BB2DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 19:00:43 +1000 (EST)
From: "Stelios Koroneos" <stelios@stelioscellar.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: Xilinx Virtex4 FX PPC
Date: Tue, 21 Aug 2007 11:52:35 +0300
Message-ID: <HOECLKEKOHLAMMGDLLBHEEGHMAAA.stelios@stelioscellar.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1187625654.6336.28.camel@PisteOff>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Question 1:
> Do I need a special glibc for the Xilinx PPC 405????

FYI we are at the last stage of implementing OpenEmbedded support for the
Xilinx ml403 (and hopefully other Xilinx boards in the near future)
It also handles the EDK header copying procedure "automagically" i.e you
point to your EDK project dir and pulls the file(s) it needs for the kernel.
We will be working to "automate" the generation of ACE files also, since OE
generates a full image (kernel+fs) and not just the toolchain.
Currently toolchain is gcc 4.1.1 with glibc 2.5 and/or uclibc 0.9.28.
There is some work done by other OE developers to get eglibc going (omap
works according to the latest info i have)

OpenEmbedded supports a number of ppc targets currently walnut
(405),sequoia(440e),efika(603e) just to mention a few

I will be speaking at the Power.org dev conference about OE and power
architecure so if anyone will be there and wishes to get some knowledge
about OE in "advance" , feel  free to drop me a mail, as we will releasing a
beta of our OE based distro soon.



Stelios S. Koroneos

Digital OPSiS - Embedded Intelligence
http://www.digital-opsis.com
