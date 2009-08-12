Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 64DEBB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 07:30:57 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A692ADDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 07:30:56 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
In-Reply-To: <4A82FC63.7020705@firmworks.com>
References: <1250063825.15143.43.camel@pasglop>
	<1250065762.15143.47.camel@pasglop>  <4A82FC63.7020705@firmworks.com>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 07:30:28 +1000
Message-Id: <1250112628.3587.22.camel@pasglop>
Mime-Version: 1.0
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 07:31 -1000, Mitch Bradley wrote:

> Padding a string violates a core principle of property representation, 
> namely the "no alignment assumptions" one.  The reason for that 
> principle was the fact that alignment needs are not stable across 
> processor families, or even within a processor family .

Right, which is why I replied to myself with a different idea :-)

> This approach finesses the problem nicely.

Thanks.

Cheers,
Ben.
