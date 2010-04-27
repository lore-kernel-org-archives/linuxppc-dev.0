Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AB51B7DDD
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 04:32:36 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RIWIEC003738
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 11:32:28 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3RIgNJ3015158
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:42:23 -0500 (CDT)
Message-ID: <4BD72DB0.20808@freescale.com>
Date: Tue, 27 Apr 2010 13:32:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>	
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>	
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>	
	<4BD70292.20001@freescale.com> <1272386470.11000.84.camel@odin>
In-Reply-To: <1272386470.11000.84.camel@odin>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liam Girdwood wrote:

>> I would need some way for fsl_dma_open() to get a pointer to private,
>> DMA-specific data.  I'm not sure how I can do that.
> 
> In multi-component we now have platform_data and device private data
> (from the regular driver model).

In that case, I still have the same problem with how to generate an 'id' based on a device tree node.  We have the idea of a 'phandle', which is a unique integer for a node, but there's no way to create phandles from within Linux.  They have to exist in the DTS first, and I'm loathe to modify the DTS.


-- 
Timur Tabi
Linux kernel developer at Freescale
