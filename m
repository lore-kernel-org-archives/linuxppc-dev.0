Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB4C3B81C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 14:14:01 +1000 (EST)
Subject: Re: [PATCH v2] PowerPC/FSL/CPM: Configure clock correctly for SCC
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1270303903-12961-1-git-send-email-weo@reccoware.de>
Date: Mon, 19 Apr 2010 23:13:50 -0500
Message-Id: <0B27BAFD-5330-4B15-81C0-1A61CF7250D1@kernel.crashing.org>
References: <1270303903-12961-1-git-send-email-weo@reccoware.de>
To: Wolfgang Ocker <weo@reccoware.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 3, 2010, at 9:11 AM, Wolfgang Ocker wrote:

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
> arch/powerpc/sysdev/cpm1.c |   14 +++++++++++---
> arch/powerpc/sysdev/cpm2.c |   11 ++++++++---
> 2 files changed, 19 insertions(+), 6 deletions(-)


applied to merge.

- k
