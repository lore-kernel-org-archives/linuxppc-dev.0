Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84BCCDDEE3
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 00:07:24 +1100 (EST)
Message-Id: <8A79C323-275E-4AA1-BC81-58F7D272FEB3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <patch-fsl-1@bga.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: remove non-dependent load fsl_booke PTE_64BIT
Date: Fri, 10 Oct 2008 08:07:19 -0500
References: <patch-fsl-1@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 10, 2008, at 6:56 AM, Milton Miller wrote:

> b38fd42ff46a4a31dced8533e8a6e549693500b6 added false dependencys
> to order the load of upper and lower halfs of the pte, but only
> adjusted whitespace instead of deleting the old load in the iside
> handler, letting the hardware see the non-dependent load.
>
> This patch removes the extra load.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---
> Kumar, I think this is right from my inspection, please review.

applied

- k
