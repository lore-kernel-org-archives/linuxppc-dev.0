Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F15E4DE0FC
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 08:35:45 +1100 (EST)
Message-Id: <DAC46F37-CA69-4666-874C-760ACE14CD88@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1232531217-16103-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/mpc8313erdb: fix kernel panic because mdio device
	is not probed
Date: Mon, 26 Jan 2009 15:35:36 -0600
References: <1232531217-16103-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 21, 2009, at 3:46 AM, Li Yang wrote:

> Probe the new mdio node added by b31a1d8b.  Fix kernel panic problem  
> when
> gianfar driver wants to get the of_platform_device of that mdio.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Supersede the patch to add "simple-bus" to gianfar node to fix this  
> problem.

applied to merge

- k
