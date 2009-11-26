Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1D331007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:23:19 +1100 (EST)
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<4B0AE603.9050208@yahoo.es>
	<fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:23:12 +1100
Message-ID: <1259209392.16367.242.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-23 at 13:19 -0700, Grant Likely wrote:
> so the node really is
> describing the internal bus, not the entire SoC.  On some chips it is
> documented as the "internally memory mapped registers", or IMMR.  So,
> it is better to name this node in a way that reflects what it is (an
> internal bus) instead of as the whole chip.

It's not even the internal bus. Flipper and Hollywood are separate chips
from the PPC afaik. They are integrated northbridge + gfx + IOs
basically.

> Similarly, it is better to use a compatible value of something like:
> compatible = "nintendo,flipper-immr"; (instead of "nintendo,flipper")
> because your describing just the internal bus, not the entire chip. 

I would just call the nodes "flipper" and "hollywood".

Cheers,
Ben.
