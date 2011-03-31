Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3888EB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 08:05:20 +1100 (EST)
Subject: Re: [PATCH] powerpc: Implement dma_mmap_coherent()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20110331203921.56030@gmx.net>
References: <20110331203921.56030@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 08:05:12 +1100
Message-ID: <1301605512.2407.72.camel@pasglop>
Mime-Version: 1.0
Cc: tiwai@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-31 at 22:39 +0200, Gerhard Pircher wrote:
> Anyway, it compiles with explicit type casts and I could test it on my
> semi-noncoherent AmigaOne. So far it works just fine with the VIA
> onboard
> sound and a Soundblaster Live PCI card.
> 
> Thanks a lot for the fix!

Yes, the version I sent to Linus has that fixed, I forgot to send it to
the list also :-)

Cheers,
Ben.
