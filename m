Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 036C5DDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:44:08 +1100 (EST)
Message-Id: <027DF188-B61E-49D9-BFB3-A9DC01FF33B5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080201180954.b0671447.kim.phillips@freescale.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] powerpc: mpc832x_rdb: fix compiler warning
Date: Tue, 5 Feb 2008 23:43:53 -0600
References: <20080201180954.b0671447.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 1, 2008, at 6:09 PM, Kim Phillips wrote:

> arch/powerpc/platforms/83xx/mpc832x_rdb.c: In function =20
> =91mpc832x_rdb_setup_arch=92:
> arch/powerpc/platforms/83xx/mpc832x_rdb.c:104: warning: =91np=92 is =
used =20
> uninitialized in this function
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied.

- k=
