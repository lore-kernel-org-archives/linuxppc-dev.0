Return-Path: <sr@denx.de>
Received: from natpreptil.rzone.de (natpreptil.rzone.de [81.169.145.163])
	by ozlabs.org (Postfix) with ESMTP id 67FE067A2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 17:54:56 +1000 (EST)
Received: from server.lan (ip51cf43f8.direct-adsl.nl [81.207.67.248])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j347gZ2E008827
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 4 Apr 2005 09:42:35 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
Date: Mon, 4 Apr 2005 09:42:34 +0200
To: "ML linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504040942.34922.sr@denx.de>
Subject: Re: Platform bus/ppc sys model - [Fwd: bi_recs and u-boot ppcboot.h]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Thursday 31 March 2005 14:36, Jon Masters wrote:

> ( basically, I've got ppcboot on an old CPCI405 here but it's not
> trivial to fix if I break it

The CPCI405 supports switching the boot-cs between its 2 flash chips with the
DIP-switch 4. You could copy the current ppcboot version into the 2nd flash
chip as a fallback (please test it once).

Please make sure to use the "CPCI405" U-Boot make-target and _not_ CPCI4052
for a revision 1.x board. To be sure what version of the board you have,
please take a look at the FPGA. If it's a Spartan 05 then it's a revision 1.x
board, if it's a Spartan 2 15 it's a revision 2.x board.

> and I don't know much about whether u-boot
> supports chaining in to a new u-boot loaded from within itself...but it
> probably does, I guess. Bah, it's late, I'm rambling...).

I am pretty sure that the current versions of U-Boot work without problems on
the CPCI405 boards (even revision 1.x).

Best regards,
Stefan
