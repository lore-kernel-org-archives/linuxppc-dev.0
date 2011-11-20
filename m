Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD357B71F0
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2011 02:51:01 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAKFotiB022239
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2011 09:50:56 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1251.1)
Subject: Re: [PATCH][v2] powerpc/p1023: set IRQ[4:6,
 11] to active-high level sensitive for PCIe
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321506575-21730-1-git-send-email-galak@kernel.crashing.org>
Date: Sun, 20 Nov 2011 09:51:01 -0600
Message-Id: <972FAEB5-713C-46DC-A396-EA8C6F1F1A37@kernel.crashing.org>
References: <1321506575-21730-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2011, at 11:09 PM, Kumar Gala wrote:

> From: Roy Zang <tie-fei.zang@freescale.com>
> 
> P1023 external IRQ[4:6, 11] are not pin out, but the interrupts are
> utilized by the PCIe controllers.  As they are not exposed as pins we
> need to set them as active-high (internal to the SoC these interrupts
> are pulled down).
> 
> IRQs[0:3,7:10] are pulled up on the board so we have them set as
> active-low.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> v2:
> * cleaned up commit message & added comments to be clear about IRQ usage

applied to merge

- k
