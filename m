Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CA21DE009
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 06:49:09 +1000 (EST)
In-Reply-To: <1180463004.13106.65.camel@ld0161-tx32>
References: <1180463004.13106.65.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F962B8B4-32C0-46A6-B808-C18211353FCC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] Modified quirk_mpc8641_transparent() to initialize
	bridge resources.
Date: Tue, 29 May 2007 15:49:00 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 1:23 PM, Jon Loeliger wrote:

> From: Jon Loeliger <jdl@freescale.com>
>
> The 8641 RC poses as a transparent bridge, but does not implement the
> IO_BASE or IO_LIMIT registers in the config space.  This means that
> the code which initializes the bridge resources ends up setting the
> IO resources erroneously.
>
> This change initializes the RC bridge resources from the device tree.
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Can this be merged with Zhang's "Set RC of mpc8641 to transparent  
bridge for transfer legacy I/O access." patch since it pretty much  
supersedes it.

- k
