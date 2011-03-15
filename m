Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55BE1B6FE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:32:07 +1100 (EST)
Subject: Re: [PATCH] powerpc/mpc8xxx_gpio: simplify searching for 'fsl,
	qoriq-gpio' compatiable
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1294501876-9331-1-git-send-email-agust@denx.de>
Date: Tue, 15 Mar 2011 10:32:00 -0500
Message-Id: <A922BB0D-7F52-4286-9BA2-4E66D59D45FA@kernel.crashing.org>
References: <1294501876-9331-1-git-send-email-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 8, 2011, at 9:51 AM, Anatolij Gustschin wrote:

> Commit da3ed89e7ce272ebcc918487e2a28736ca0dd6bb added
> 'fsl,qoriq-gpio' compatiable searching in the old way
> using for_each_compatible_node(). But the driver have
> previously been changed to use a struct of_device_id
> compatible list passed to for_each_matching_node().
> 
> Add 'fsl,qoriq-gpio' compatiable to the existing
> compatible list instead of adding another
> for_each_compatible_node() loop.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> arch/powerpc/sysdev/mpc8xxx_gpio.c |    4 +---
> 1 files changed, 1 insertions(+), 3 deletions(-)

applied

- k
