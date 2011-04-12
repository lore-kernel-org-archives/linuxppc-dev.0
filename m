Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C1E3EB6F29
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 07:28:05 +1000 (EST)
Date: Tue, 12 Apr 2011 14:27:27 -0700 (PDT)
Message-Id: <20110412.142727.39177723.davem@davemloft.net>
To: prabhakar@freescale.com
Subject: Re: [PATCH] driver/e1000e: Fix default interrupt mode select
From: David Miller <davem@davemloft.net>
In-Reply-To: <1302584163-22318-1-git-send-email-prabhakar@freescale.com>
References: <1302584163-22318-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: meet2prabhu@gmail.com, auke-jan.h.kok@intel.com, linux.nics@intel.com,
	b24347@freescale.com, e1000-devel@lists.sourceforge.net,
	netdev@vger.kernel.org, jeffrey.t.kirsher@intel.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Tue, 12 Apr 2011 10:26:03 +0530

> From: Prabhakar <prabhakar@freescale.com>
> 
> The Intel e1000 device driver defaults to MSI interrupt mode, even if MSI
> support is not enabled
> 
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)
> 
>  added  netdev mail-list and e1000 mail-list & maintainer

Intel folks, you got this?
