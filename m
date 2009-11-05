Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DE7AB7F70
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:30:44 +1100 (EST)
Subject: Re: [PATCH] powerpc/83xx: Fix u-boot partion size for MPC8377E-WLAN
	boards
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091016164722.GA13433@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:30:40 -0600
Message-Id: <5DE33BA9-3B1C-4FBD-9F55-3CE82D1F0336@kernel.crashing.org>
References: <20091016164722.GA13433@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 16, 2009, at 11:47 AM, Anton Vorontsov wrote:

> u-boot partition size should be 0x80000 (512 KB), not 0x8000 (32 KB).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_wlan.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k
