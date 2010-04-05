Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5FCAB7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Apr 2010 04:06:58 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o35I6cvd020965 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Apr 2010 11:06:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o35IFvEu021823
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Apr 2010 13:15:57 -0500 (CDT)
Message-ID: <4BBA2687.3030608@freescale.com>
Date: Mon, 05 Apr 2010 13:05:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH v2] PowerPC/FSL/CPM: Configure clock correctly for SCC
References: <1270303903-12961-1-git-send-email-weo@reccoware.de>
In-Reply-To: <1270303903-12961-1-git-send-email-weo@reccoware.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Ocker wrote:
> Some board setup functions call cpm1_clk_setup() or cmp2_clk_setup()
> to configure the clock source.
> 
> If CPM_CLK_RTX has been used for the parameter mode,
> the clock has been configured only for TX but not for RX.
> 
> With this patch CPM_CLK_RTX configures the clock for both directions
> correctly.
> 
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> ---
> 
> v2: Scott Wood encouraged me to include a similar fix for CPM2.
> 
>  arch/powerpc/sysdev/cpm1.c |   14 +++++++++++---
>  arch/powerpc/sysdev/cpm2.c |   11 ++++++++---
>  2 files changed, 19 insertions(+), 6 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
