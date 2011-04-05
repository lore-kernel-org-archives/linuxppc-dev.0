Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3BBFB6F44
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 21:59:47 +1000 (EST)
Subject: Re: checking status semantics with compatible functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20110330143113.GA13685@ponder.secretlab.ca>
References: <9BC4C90E-090F-4961-A242-10D769C08738@kernel.crashing.org>
	<C1B3133E-0EEE-49E9-9E3A-35026CFA78E9@kernel.crashing.org>
	<20110330143113.GA13685@ponder.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 21:59:36 +1000
Message-ID: <1302004776.2549.153.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-30 at 08:31 -0600, Grant Likely wrote:
> Yes, of_device_is_available() should be checked, but it should not be
> added directly to of_device_is_compatible().  I'm okay with adding
> a helper variant that does the of_device_is_compatible() check.
> 
> In that particular case, I'd also suggest using
> for_each_matching_node().

Agreed. A device might be unavailable due to how FW configured the
machine, but made later on available by the kernel, that shouldn't
impact the interface compatibility test.

Cheers,
Ben.
