Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56CEFDEFCE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:11:58 +1000 (EST)
Message-Id: <84196E11-4A65-4DB7-AA66-4874CE337B8B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311172424.GE7727@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 5/8] [POWERPC] qe_lib: export qe_get_brg_clk()
Date: Mon, 14 Apr 2008 10:11:54 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172424.GE7727@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
> qe_get_brg_clk() will be used by the fsl_gtm routines.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |    5 +++--
> include/asm-powerpc/qe.h        |    1 +
> 2 files changed, 4 insertions(+), 2 deletions(-)

applied.

- k
