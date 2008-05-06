Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16B34DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 18:48:51 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080506075115.269150@gmx.net>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net>
Content-Type: text/plain
Date: Tue, 06 May 2008 18:48:39 +1000
Message-Id: <1210063719.21644.162.camel@pasglop>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, cjg@cruxppc.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-06 at 09:51 +0200, Gerhard Pircher wrote:
> Takashi Iwai posted a preliminary patch a long time ago. I tested it
> on my
> machine and it failed with non coherent scatter-gather DMA allocations
> (I guess almost all ALSA PCI drivers use SG DMA?).

How does Alsa allocate such SG ? 

Ben.
