Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E77841007DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 16:04:22 +1100 (EST)
Subject: Re: [PATCH] Do not hide resource for pci/pcie when configured as
 Agent/EP
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1319789280-12091-1-git-send-email-B38951@freescale.com>
Date: Wed, 23 Nov 2011 23:04:14 -0600
Message-Id: <771401A4-167A-44DB-8FCB-0FE9F81243FC@kernel.crashing.org>
References: <1319789280-12091-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 28, 2011, at 3:08 AM, Jia Hongtao wrote:

> From: Jason Jin <Jason.jin@freescale.com>
> 
> Current pci/pcie init code will hide the pci/pcie host resource.
> But did not judge it is host/RC or agent/EP. If configured as
> agent/EP, we should avoid hiding its resource in the host side.
> 
> In PCI system, the Programing Interface can be used to judge the
> host/agent status:
> Programing Interface = 0: host
> Programing Interface = 1: Agent
> 
> In PCIE system, both the Programing Interface and Header type can
> be used to judge the RC/EP status.
> Header Type = 0: EP
> Header Type = 1: RC
> 
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/kernel/pci-common.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)

applied to next

- k
