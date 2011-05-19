Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D40BAB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:37:41 +1000 (EST)
Subject: Re: [PATCH] powerpc/qoriq: Add default mode for P1020RDB USB
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1304515616-3413-1-git-send-email-ramneek.mehresh@freescale.com>
Date: Thu, 19 May 2011 01:37:31 -0500
Message-Id: <25CA2458-BE3F-46E7-8516-16A504B2294D@kernel.crashing.org>
References: <1304515616-3413-1-git-send-email-ramneek.mehresh@freescale.com>
To: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 4, 2011, at 8:26 AM, Ramneek Mehresh wrote:

> Add P1020 USB controller default value for "dr_mode" property
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> ---
> Applies on git://git.am.freescale.net/mirrors/linux-2.6.git
> (branch master)
> arch/powerpc/boot/dts/p1020rdb.dts |   10 ++++------
> 1 files changed, 4 insertions(+), 6 deletions(-)

Can you update the patch.  Also make sure to update the p1020rdb_camp* .dts

Against git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

thanks

- k
