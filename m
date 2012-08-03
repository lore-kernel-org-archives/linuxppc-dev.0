Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33C9D2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 00:11:29 +1000 (EST)
Subject: Re: [PATCH V5 1/3] powerpc/fsl-pci: Only scan PCI bus if configured
 as a host
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343988851-884-2-git-send-email-B38951@freescale.com>
Date: Fri, 3 Aug 2012 08:57:18 -0500
Message-Id: <B1B11A36-1054-43F3-A478-9D1F4249B8A4@kernel.crashing.org>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-2-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 3, 2012, at 5:14 AM, Jia Hongtao wrote:

> We change fsl_add_bridge to return -ENODEV if the controller is working in
> agent mode. Then check the return value of fsl_add_bridge to guarantee
> that only successfully added host bus will be scanned.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   13 ++++++++-----
> 1 files changed, 8 insertions(+), 5 deletions(-)

applied to merge

- k
