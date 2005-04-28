Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.182.167]) by ozlabs.org (Postfix) with ESMTP id 477A967B2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 22:04:46 +1000 (EST)
Message-ID: <00f101c54bea$7b5d26e0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>,
	"Peter 'p2' De Schrijver" <p2@mind.be>
References: <20050428094716.GA17582@mind.be>
Date: Thu, 28 Apr 2005 08:04:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: connecting BDI2000 to ML403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Hi,
>
>I'm trying to figure out how to connect the BDI 2000 with a Xilinx ML403 
>development board. As far as I can see in the ML403 schematics, the JTAG
>connector lacks the nTRST and the HALT signals needed for JTAG
>debugging. Any ideas ?
>
>Thanks,
>
>Peter (p2).

The BDI doesn't need nTRST or HALT, so that's not your problem.  nTRST
must be pulled high, but the BDI doesn't need to drive that signal.

Mark Chambers
