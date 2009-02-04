Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A152FDDE41
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 07:47:32 +1100 (EST)
Subject: Re: [PATCH v2 1/4] Add platform support for AmigaOne
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090204120928.102380@gmx.net>
References: <20090202212139.69160@gmx.net>  <20090202213910.258290@gmx.net>
	<1233719407.16867.164.camel@pasglop>  <20090204120928.102380@gmx.net>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 07:47:16 +1100
Message-Id: <1233780436.4612.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-04 at 13:09 +0100, Gerhard Pircher wrote:
> I agree that these addresses should come from the device-tree, but these
> two config registers are not located within the normal PCI I/O address
> space (0xfe000000-0xfec00000).
> Maybe I should add a "reg" property to the PHB node, but I don't know if
> this is the right approach. The OF PCI spec isn't very clear about this.
> What do you think?

Yup, "reg" in the PHB is what most machines use for that.

Cheers,
Ben.
