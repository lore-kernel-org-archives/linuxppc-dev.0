Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1601B700A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 04:21:17 +1100 (EST)
Subject: Re: [PATCH] corenet64_smp_defconfig:Added I2C_CHARDEV and I2C_MPC
 options in defconfig to have compiled I2C device interface
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331974736-14450-1-git-send-email-shaveta@freescale.com>
Date: Wed, 21 Mar 2012 12:21:13 -0500
Message-Id: <D7A20294-CE3C-4FF9-91F0-B22A354560AA@kernel.crashing.org>
References: <1331974736-14450-1-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 17, 2012, at 3:58 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---
> arch/powerpc/configs/corenet64_smp_defconfig |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

applied, squashed to a single commit for all 4 and updated commit message

- k
