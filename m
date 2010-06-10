Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
	<20100608155702.GA5419@oksana.dev.rtsoft.ru>
	<AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
	<20100608164645.GA15216@oksana.dev.rtsoft.ru>
	<AANLkTinHH-YhdWpH60Z2BYsiEjzLb_imrk6KUmQRH07P@mail.gmail.com>
	<20100608194809.GA32732@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:17:43 +1000
Message-ID: <1276150663.1962.43.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> You just introduced an unnamed structure of device + resources,
> it isn't declared anywhere but in the code itself (either via
> &foo[1] or buf + sizeof(*foo)).
> 
> You're not the only one who hacks (or at least have to
> understand) the OF stuff, so let's try keep this stuff
> readable?
> 
> I told you several ways of how to improve the code (based on
> the ideas from drivers/base/, so the ideas aren't even mine,
> fwiw).

I tend to agree with Anton here.

BTW. Why not make of_device a wrapper (or even alias of)
platform_device ? :-) That way you get the resource array etc.. for free
and it will make the whole of_device vs. platform_device issue moot.

Cheers,
Ben.
