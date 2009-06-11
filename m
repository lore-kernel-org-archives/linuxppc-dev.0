Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A41E9B7A63
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:51:22 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E99FEDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:51:21 +1000 (EST)
Message-Id: <35E6ECD2-30B1-4BCD-A46A-01683AA16C7D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090610151926.GA32386@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/83xx: Update sdhci nodes per new bindings
Date: Wed, 10 Jun 2009 20:51:10 -0500
References: <20090610151926.GA32386@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 10, 2009, at 10:19 AM, Anton Vorontsov wrote:

> As of commit 404614728f857d0ac63d29c3a29d0cf392a15598 ("Update FSL
> esdhc binding"), we use "fsl,esdhc" compatible entry as a base
> match. U-Boot will use the same compatible to fixup esdhc nodes.
>
> This patch updates 83xx dts files so that they conform to the new
> bindings.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |    2 +-
> arch/powerpc/boot/dts/mpc8377_rdb.dts |    2 +-
> arch/powerpc/boot/dts/mpc8378_mds.dts |    2 +-
> arch/powerpc/boot/dts/mpc8378_rdb.dts |    2 +-
> arch/powerpc/boot/dts/mpc8379_mds.dts |    2 +-
> arch/powerpc/boot/dts/mpc8379_rdb.dts |    2 +-
> 6 files changed, 6 insertions(+), 6 deletions(-)


applied to next.

- k
