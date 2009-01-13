Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07AA9DE16F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 02:45:17 +1100 (EST)
Message-Id: <4771D084-6987-4668-8F90-142854FD331C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-4-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 4/5] powerpc: booke: Make CAM entries used for lowmem
	configurable
Date: Tue, 13 Jan 2009 09:43:10 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
	<1228793699-23110-4-git-send-email-tpiepho@freescale.com>
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

> On booke processors, the code that maps low memory only uses up to  
> three
> CAM entries, even though there are sixteen and nothing else uses them.
>
> Make this number configurable in the advanced options menu along  
> with max
> low memory size.  If one wants 1 GB of lowmem, then it's typically
> necessary to have four CAM entries.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/Kconfig            |   16 ++++++++++++++++
> arch/powerpc/mm/fsl_booke_mmu.c |    6 +++++-
> 2 files changed, 21 insertions(+), 1 deletions(-)

applied

- k
