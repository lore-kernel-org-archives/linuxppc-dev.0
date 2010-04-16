Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 788C6B7D1B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Apr 2010 01:54:41 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3GFscpl020977
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 08:54:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3GG4L3g017904
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 11:04:21 -0500 (CDT)
Message-ID: <4BC8883C.8050703@freescale.com>
Date: Fri, 16 Apr 2010 10:54:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH v3] powerpc: Add hibernation support for FSL BookE
	processors
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com> <4BC77497.9070401@freescale.com>
	<20100416115643.GA3092@oksana.dev.rtsoft.ru>
In-Reply-To: <20100416115643.GA3092@oksana.dev.rtsoft.ru>
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

Anton Vorontsov wrote:
> +	/* Invalidate TLB0 & TLB1 */
> +	li	r6,0x04
> +	tlbivax 0,r6
> +	TLBSYNC
> +	li	r6,0x0c
> +	tlbivax 0,r6
> +	TLBSYNC

Is this needed?  Shouldn't the boot process have already given us a sane 
TLB?

-Scott
