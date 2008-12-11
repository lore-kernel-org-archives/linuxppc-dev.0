Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2A56474C3
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 06:18:09 +1100 (EST)
Message-ID: <49416765.5090101@freescale.com>
Date: Thu, 11 Dec 2008 13:17:57 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mark Brown <broonie@sirena.org.uk>
Subject: Re: MPC8610HPCD sound as module
References: <49411308.1050008@fang.fa.gau.hu>
	<ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
	<20081211153158.GF30808@sirena.org.uk>
	<49413487.9030805@freescale.com>
	<20081211154411.GG30808@sirena.org.uk>
	<49413596.6030803@freescale.com>
	<20081211185255.GA16784@sirena.org.uk>
In-Reply-To: <20081211185255.GA16784@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:

> Well, from that point of view now would be a good time for you to start
> backporting your newer code.  The concept of having the core wait for
> subdevices to probe is now there which was the major win from the point
> of view of integration with the device tree.  What's there now also has
> the changes you wanted without the use of templates in the ASoC core so
> you can do a single memory allocation for devices rather than having to
> fill out templates and have the core do allocations for you.

Okee dokee.  I'll start working on it next month.

-- 
Timur Tabi
Linux kernel developer at Freescale
