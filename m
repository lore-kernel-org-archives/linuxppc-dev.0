Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E576C2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 03:18:15 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: enable E1000 NIC to mpc85xx_defconfig
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363275622-1412-1-git-send-email-tie-fei.zang@freescale.com>
Date: Fri, 15 Mar 2013 11:16:50 -0500
Message-Id: <EDE13355-D671-4154-B090-0C1F847689C3@kernel.crashing.org>
References: <1363275622-1412-1-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: b36666@freescale.com, B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2013, at 10:40 AM, Roy Zang wrote:

> E1000 NIC is a common used Ethernet card. Enable it as default
> for mpc85xx platform.
> 
> other change is due to make savedefconfig
> 
> Reported-by: Fu Jiwei <b36666@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> tested on P1010rdb board
> arch/powerpc/configs/mpc85xx_defconfig |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

applied to next

- k
