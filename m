Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA749DDF0B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 03:13:30 +1100 (EST)
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Williams <dan.j.williams@gmail.com>
In-Reply-To: <e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
	<200703171943.27465.sr@denx.de>
	<e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 17:13:19 +0100
Message-Id: <1174320799.5044.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW folks. Would it be hard to change your spe_ prefixes to something
else ? There's already enough confusion between the freescale SPE unit
and the cell SPEs :-)

(such confusion is annoying when grepp'ing for code that might touch a
given functionality for example).

Cheers,
Ben.
