Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9478DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 17:47:22 +1100 (EST)
In-Reply-To: <45C9680C.6030601@freescale.com>
References: <45C9680C.6030601@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5C254007-387E-448F-A38A-CE43DEDD194E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Thu, 8 Feb 2007 00:46:20 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 11:47 PM, Li Yang wrote:

> Add board specific initialization code for USB
> to work in both MPH and DR mode for MPC8349EMDS
> PB board.
>
> Signed-off-by: Li Yang <leoli@freescale.com> ---
> arch/powerpc/platforms/83xx/mpc834x_sys.c |   74 +++++++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/83xx/mpc834x_sys.h |    2 +
> arch/powerpc/platforms/83xx/mpc83xx.h     |   18 +++++++
> 3 files changed, 94 insertions(+), 0 deletions(-)

applied

- k
