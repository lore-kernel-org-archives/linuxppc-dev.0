Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FBC0DDF4F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:05:23 +1100 (EST)
Subject: Re: macros and dtc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 07:04:44 +1100
Message-Id: <1171915484.18571.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I could envision using something like cpp with #include
> to get some standard SOC block properties, but macros
> that try to account for board variations could be quite
> complex.

For things like SoC, what I'd like is a way via #include or macros,
whatever, to layout in a part of the tree a standard block, and then, be
able to "overlay" on top of it.

I can see other uses for macros for things like making easier to build
interrupt-map properties for example, especially since most embedded
boards use standard swizzling

Ben.
