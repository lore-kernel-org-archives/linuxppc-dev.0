Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21196DDF08
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 18:19:25 +1100 (EST)
Message-Id: <6867E746-3CD5-4A49-8941-429CAEB1CCDD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1196716685975-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] ucc_geth: use rx-clock-name and tx-clock-name device
	tree properties
Date: Fri, 14 Dec 2007 01:19:05 -0600
References: <11967166791607-git-send-email-timur@freescale.com>
	<1196716680381-git-send-email-timur@freescale.com>
	<1196716685975-git-send-email-timur@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2007, at 3:17 PM, Timur Tabi wrote:

> Updates the ucc_geth device driver to check the new rx-clock-name and
> tx-clock-name properties first.  If present, it uses the new function
> qe_clock_source() to obtain the clock source.  Otherwise, it checks  
> the
> deprecated rx-clock and tx-clock properties.
>
> Update the device trees for 832x, 836x, and 8568 to contain the new  
> property
> names only.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch applies to Kumar's for-2.6.25 branch.  ucc_geth will  
> compile but not
> run if my other patch, "qe: add function qe_clock_source" has not  
> also been
> applied.
>
> arch/powerpc/boot/dts/mpc832x_mds.dts |    8 ++--
> arch/powerpc/boot/dts/mpc832x_rdb.dts |    8 ++--
> arch/powerpc/boot/dts/mpc836x_mds.dts |    8 ++--
> arch/powerpc/boot/dts/mpc8568mds.dts  |    8 ++--
> drivers/net/ucc_geth.c                |   55 ++++++++++++++++++++++++ 
> ++++++--
> 5 files changed, 67 insertions(+), 20 deletions(-)

applied.

- k
