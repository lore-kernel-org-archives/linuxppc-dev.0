Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.131.36]) by ozlabs.org (Postfix) with ESMTP id 13E4B67A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 07:26:56 +1100 (EST)
Received: from filter01.roc.ny.frontiernet.net
	(filter01.roc.ny.frontiernet.net [66.133.131.176])
	by relay03.roc.ny.frontiernet.net (Postfix) with ESMTP id B6131191C77
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 20:26:53 +0000 (UTC)
Received: from relay03.roc.ny.frontiernet.net ([66.133.131.36])
	by filter01.roc.ny.frontiernet.net (filter01.roc.ny.frontiernet.net
	[66.133.131.176]) (amavisd-new, port 10024)
	with LMTP id 02718-02-49 for <linuxppc-embedded@ozlabs.org>;
	Mon, 7 Feb 2005 20:26:53 +0000 (UTC)
Received: from chuck2 (70-97-124-241.br1.rmn.wv.frontiernet.net
	[70.97.124.241])
	by relay03.roc.ny.frontiernet.net (Postfix) with ESMTP id 6C40D191B1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 20:26:46 +0000 (UTC)
Message-ID: <00a001c50d53$e87d4e60$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <20050207195520.D8B4DC108D@atlas.denx.de>
Date: Mon, 7 Feb 2005 15:30:41 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> This will not work. Microwindows can only  use  a  plain  framebuffer
> interface,  but  the Coral-P does not allow for such a driver because
> of the fact that it has a little-endian register interface.  

Or is it because 5200 swaps bytes around on PCI.  It sure looks to me
like Freescale has made a major screwup in their implementation of
PCI on the 5200.  I'd love for somebody to prove me wrong about this,
but I'm afraid I'm right.  I was under the impression that CoralP worked
nicely on 5200, but now I see that it also requires software tweaks to work
on 5200.  

Mark Chambers
