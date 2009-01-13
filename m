Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AA4CDE0DE
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 02:45:11 +1100 (EST)
Message-Id: <C8834779-1957-4634-BF75-786C0D946C36@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-3-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/5] powerpc: booke: Remove code duplication in lowmem
	mapping
Date: Tue, 13 Jan 2009 09:43:01 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
	<1228793699-23110-3-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2008, at 9:34 PM, Trent Piepho wrote:

> The code to map lowmem uses three CAM aka TLB[1] entries to cover  
> it.  The
> size of each is stored in three globals named __cam0, __cam1, and  
> __cam2.
> All the code that uses them is duplicated three times for each of  
> the three
> variables.
>
> We have these things called arrays and loops....
>
> Once converted to use an array, it will be easier to make the number  
> of
> CAMs configurable.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/mm/fsl_booke_mmu.c |   79 ++++++++++++++ 
> +-----------------------
> 1 files changed, 31 insertions(+), 48 deletions(-)

applied.  Still not happy about the buf[] for output, but its minor.

- k
