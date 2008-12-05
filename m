Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55C5BDDDEF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 11:50:48 +1100 (EST)
Message-Id: <D3ADB80B-5A8C-4D10-8FB9-CB29392E68B5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081204175231.GA28554@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Enable FIXED_PHY in mpc834x_itx and mpc83xx
	defconfigs
Date: Thu, 4 Dec 2008 18:48:36 -0600
References: <ed82fe3e0812040915i696e99bep75a37b0e38154415@mail.gmail.com>
	<20081204175231.GA28554@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	Timur Tabi <timur@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2008, at 11:52 AM, Anton Vorontsov wrote:

> This is needed so that Vitesse 7385 5-port switch could work on
> MPC8349E-mITX boards.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

applied to merge.

Guys, can you put a [for 2.6.28] or something if a patch is intended  
for .28.. this way I hopefully pay a bit more attention.

- k
