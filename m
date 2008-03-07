Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8245DDDF25
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:04:08 +1100 (EST)
Message-Id: <4587F273-ECF6-4157-A561-68BEA3969159@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1204800146-11591-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/2] fix wrong USB phy type in mpc837xmds dts
Date: Fri, 7 Mar 2008 08:47:04 -0600
References: <1204800146-11591-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2008, at 4:42 AM, Li Yang wrote:

> Due to chip constraint MPC837x USB DR module can only use
> ULPI and serial PHY interfaces.  The patch fixes the wrong
> type in dts.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8378_mds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8379_mds.dts |    4 ++--
> 3 files changed, 6 insertions(+), 6 deletions(-)

applied.

- k
