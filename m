Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D182167B5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 06:39:54 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1GOKAb-0008Cc-1J
	for linuxppc-embedded@ozlabs.org; Fri, 15 Sep 2006 13:20:17 -0700
Message-ID: <6332541.post@talk.nabble.com>
Date: Fri, 15 Sep 2006 13:20:17 -0700 (PDT)
From: jbahr <jbahr@set-software-services.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: JTAG Flash programmer for MPC8248
In-Reply-To: <1628E43D99629C46988BE46087A3FBB96F60ED@ep-01.EmbeddedPlanet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <200609131138.45308.laurent.pinchart@tbox.biz>
	<995B09A8299C2C44B59866F6391D263516B886@zch01exm21.fsl.freescale.net>
	<1628E43D99629C46988BE46087A3FBB96F60ED@ep-01.EmbeddedPlanet.local>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


We've used the Macraigor Wiggler on an 8548 board.  It's MUCH slower than the
BDI, but it does work.  We've also tried their Raven and USB products (about
$750) but they didn't work or were no faster than the Wriggler.

J



Steven Blakeslee wrote:
> 
>> 
>> I know the BDI2000 is able to program the target flash 
>> memory, but I'm looking for a less expensive solution (I 
>> don't need debugging capabilities, just a plain flash programmer).
>> 
> 
> Macraigor is cost effective.
> http://www.macraigor.com/
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/JTAG-Flash-programmer-for-MPC8248-tf2264010.html#a6332541
Sent from the linuxppc-embedded forum at Nabble.com.
