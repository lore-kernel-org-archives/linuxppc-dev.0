Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 04CDAB72B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 12:25:53 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56FD2DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 12:25:52 +1000 (EST)
Message-Id: <7898009C-2A9D-45D3-8C2B-1AFA90C4CB31@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090618233752.GA13279@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: Make eSDHC 1-bit only transfer mode default
	for MPC8569E-MDS
Date: Thu, 18 Jun 2009 21:25:46 -0500
References: <20090618233752.GA13279@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 18, 2009, at 6:37 PM, Anton Vorontsov wrote:

> For yet unknown reason 4-bit mode doesn't work on MPC8569E-MDS boards,
> so make 1-bit mode default. When we resolve the issue, u-boot will
> remove sdhci,1-bit-only property from the device tree, while SDHCI
> will still work with older u-boots.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Did I miss the patch that adds this property defn. to our docs?

- k
