Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72348DDE27
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 05:27:23 +1000 (EST)
Message-ID: <46952F11.30005@freescale.com>
Date: Wed, 11 Jul 2007 14:27:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
	<22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
	<4694F7A2.6040403@freescale.com>
	<01035B4E-01EB-479A-9AA7-BCFBF6C60904@kernel.crashing.org>
	<46951EE0.6040603@freescale.com>
	<12728378-7DC8-41D9-BCF4-5F883F651E40@kernel.crashing.org>
	<4695298A.6090604@freescale.com>
	<5790B879-A6F0-4FE7-91FC-9FA812BF8231@kernel.crashing.org>
In-Reply-To: <5790B879-A6F0-4FE7-91FC-9FA812BF8231@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> What if the mem-to-mem channels were explicitly labelled  
>> fsl,mpc8548-dma-mem-to-mem?
> 
> 
> Why would you?  Why would you put _any_ compatible property in
> the individual channels, even; they aren't separate devices
> after all.

They should be. :-)

-Scott
