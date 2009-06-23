Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D514FB707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 23:05:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20769DDDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 23:05:01 +1000 (EST)
Message-Id: <30F2A75D-3440-4D13-981C-7DF02A983840@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090618233752.GA13279@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: Make eSDHC 1-bit only transfer mode default
	for MPC8569E-MDS
Date: Tue, 23 Jun 2009 08:04:52 -0500
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

applied to next

- k
