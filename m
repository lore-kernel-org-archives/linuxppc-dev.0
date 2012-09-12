Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1DB732C038E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 06:20:35 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/pci: Use PCIe IP block revision register
 instead of compatible
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1346664130-7896-2-git-send-email-tie-fei.zang@freescale.com>
Date: Wed, 12 Sep 2012 15:20:33 -0500
Message-Id: <BF202913-DA19-48EA-8AD6-2223918F19E6@kernel.crashing.org>
References: <1346664130-7896-1-git-send-email-tie-fei.zang@freescale.com>
 <1346664130-7896-2-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 3, 2012, at 4:22 AM, Roy Zang wrote:

> Freescale PCIe IP block revision bigger than rev2.2 will also need
> redefine the sequence of inbound windows. So change to use IP block
> revision instead of compatible for the judgment.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> 
> arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++------
> 1 files changed, 8 insertions(+), 6 deletions(-)

applied to next

- k
