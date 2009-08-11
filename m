Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EB288B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 23:49:33 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C81CDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 23:49:33 +1000 (EST)
Message-Id: <A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090807195822.GG2735@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 7/7] powerpc/85xx: Add eSDHC support for MPC8536DS boards
Date: Tue, 11 Aug 2009 08:48:32 -0500
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
	<20090807195822.GG2735@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 7, 2009, at 2:58 PM, Anton Vorontsov wrote:

> This patch simply adds sdhci node to the device tree.
>
> We specify clock-frequency manually, so that eSDHC will work without
> upgrading U-Boot. Though, that'll only work for default setup (1500
> MHz) on new board revisions. For non-default setups, it's recommended
> to upgrade U-Boot, since it will fixup clock-frequency automatically.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8536ds.dts |    8 ++++++++
> 1 files changed, 8 insertions(+), 0 deletions(-)

Can you update the mpc8536ds_36b.dts as well (its in my next branch)

- k
