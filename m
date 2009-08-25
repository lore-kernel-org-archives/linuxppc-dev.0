Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF591B7C83
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 00:44:52 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 289E5DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 00:44:51 +1000 (EST)
Message-Id: <08947223-ECE8-48A0-AC8C-262A7FCE8BA2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090818232821.GC27907@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 3/3] powerpc/85xx: Add QE USB support for MPC8569E-MDS
	boards
Date: Tue, 25 Aug 2009 09:44:47 -0500
References: <20090818232821.GC27907@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 6:28 PM, Anton Vorontsov wrote:

> - Add gpio-controller node for BCSR17, it is used to control USB
>  speed and VBUS;
> - Add timer node for QE GTM, needed for USB host;
> - Add usb node itself;
> - Add some probing code for BCSR GPIOs.
>
> NOTE: QE USB doesn't work on prototype boards, but should work on
>      pilot boards if specs and schematics are correct, though we
>      don't have the pilot boards to actually test it.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts      |   45 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 ++
> 2 files changed, 49 insertions(+), 0 deletions(-)


applied to next.

- k
