Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CA96EB7BD8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 00:44:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AAA8DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 00:44:49 +1000 (EST)
Message-Id: <66E261E3-1F8D-4CEA-99E4-4A0DD8A0A0F1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090818232817.GB27907@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/3] powerpc/82xx: Add CPM USB Gadget support for
	MPC8272ADS boards
Date: Tue, 25 Aug 2009 09:44:42 -0500
References: <20090818232817.GB27907@oksana.dev.rtsoft.ru>
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

> - Add usb node;
> - Configure pins and clocks;
> - Enable USB function in BCSR.
>
> The support was successfully tested using serial and ethernet gadget
> drivers.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8272ads.dts      |    8 ++++++++
> arch/powerpc/platforms/82xx/mpc8272_ads.c |   14 ++++++++++++++
> 2 files changed, 22 insertions(+), 0 deletions(-)


applied to next.

- k
