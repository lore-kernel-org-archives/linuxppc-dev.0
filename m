Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69D732C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2012 00:07:23 +1000 (EST)
Subject: Re: [PATCH] powerpc:Update Integrated Flash controller device tree
 bindings
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1345043632-28535-1-git-send-email-prabhakar@freescale.com>
Date: Fri, 17 Aug 2012 09:07:16 -0500
Message-Id: <FE96BD48-70FD-4D60-BBDB-369890841A06@kernel.crashing.org>
References: <1345043632-28535-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 15, 2012, at 10:13 AM, Prabhakar Kushwaha wrote:

> Freescale's Integrated Flash controller (IFC) may have one or two
> interrupts. In case of single interrupt line, it will cover all IFC
> interrupts.
> 
> Update this information in IFC device tree bindings
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Base upon git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> Branch next
> 
> .../devicetree/bindings/powerpc/fsl/ifc.txt        |    9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

applied to next

- k
