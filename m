Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 011B0DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 08:20:48 +1100 (EST)
Subject: Re: Latest paulus.git PCI broken on mpc8540?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <473E084B.4080703@anagramm.de>
References: <473C7FCC.7050307@anagramm.de>
	<4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>
	<1195191333.28865.140.camel@pasglop>
	<A4E1A594-5A31-4EFE-B4F9-E4B24F9207F7@kernel.crashing.org>
	<1195247357.28865.178.camel@pasglop>  <473E084B.4080703@anagramm.de>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 08:20:39 +1100
Message-Id: <1195248039.28865.180.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
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
> I don't know much of the code, so, propably a stupid question:
> Can we avoid to do the initial resource allocation, when it's known to fail?
> 
> It seems to me like things are done twice here:
> 1. try
> 2. reallocate
> 3. retry

Well, we don't know it's going to fail until we try :-)

Ben.
