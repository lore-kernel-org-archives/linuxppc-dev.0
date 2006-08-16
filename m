Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 962A467B61
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:16:01 +1000 (EST)
Subject: Re: [PATCH] Convert to mac-address for ethernet MAC address data.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0D9BEF4A-F8A5-42C5-9962-8C88322C9F50@kernel.crashing.org>
References: <1154640338.26770.34.camel@cashmere.sps.mot.com>
	<0D9BEF4A-F8A5-42C5-9962-8C88322C9F50@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:15:51 +0200
Message-Id: <1155770152.11312.112.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 16:49 -0500, Kumar Gala wrote:
> On Aug 3, 2006, at 4:25 PM, Jon Loeliger wrote:
> 
> > onvert to mac-address for ethernet MAC address data.
> >
> > Also accept "local-mac-address".  However the old "address"
> > is now obsolete, but accepted for backwards compatibility.
> > It should be removed after all device trees have been
> > converted to use "mac-address".

Why not stick to local-mac-address as this is the OF standard ?

Cheers,
Ben.
