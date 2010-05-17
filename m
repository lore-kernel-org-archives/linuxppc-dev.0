Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FC14B7DDD
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 04:12:40 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4HICcfr003204
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 11:12:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o4HIChgx016676
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 13:12:43 -0500 (CDT)
Message-ID: <4BF18715.8050201@freescale.com>
Date: Mon, 17 May 2010 13:12:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH v4] powerpc: Add hibernation support for FSL BookE
	processors
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com> <4BC77497.9070401@freescale.com>
	<20100416115643.GA3092@oksana.dev.rtsoft.ru>
	<4BC8883C.8050703@freescale.com>
	<20100416190319.GA4104@oksana.dev.rtsoft.ru>
In-Reply-To: <20100416190319.GA4104@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2010 02:03 PM, Anton Vorontsov wrote:
> +	/* restore the MSR */
> +	lwz	r3,SL_MSR(r11)
> +
> +	/* Restore TB */
> +	li	r3,0

Missing mtmsr?

Otherwise ACK.

-Scott
