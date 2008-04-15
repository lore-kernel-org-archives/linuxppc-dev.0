Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8D38DE154
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:20:09 +1000 (EST)
Message-Id: <AAE554D6-9842-465E-84CA-D3FCC4D2FD63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080318154359.GB31173@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] 83xx: mpc837x_rdb: add simple-bus compatible
	matching
Date: Tue, 15 Apr 2008 18:20:03 -0500
References: <20080318154359.GB31173@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 18, 2008, at 10:43 AM, Anton Vorontsov wrote:
> This is needed to probe nor and nand flashes on the localbus.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied.

- k
