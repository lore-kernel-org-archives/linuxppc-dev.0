Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FCECDE3BC
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:08:50 +1000 (EST)
Message-Id: <BB630010-55E8-452C-9C99-0203634C4A23@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080708191333.9eb5310a.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v4] powerpc: update crypto node definition and device tree
	instances
Date: Wed, 9 Jul 2008 08:08:30 -0500
References: <20080708191333.9eb5310a.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 8, 2008, at 7:13 PM, Kim Phillips wrote:

> delete obsolete device-type property, delete model property
> (use compatible property instead), prepend "fsl," to Freescale
> specific properties. Add nodes to device trees that are missing them,
> and fix broken property values in other trees.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> changes from v3: sec.txt in new place following Kumar's latest
> preference, cleaned up interrupt description and removed
> interrupt-parent in documentation.

applied.

I fixed mpc832x_rdb.dts and mpc8536ds.dts as there were minor issues  
related to the interrupt props in those nodes.

- k
