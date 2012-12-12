Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD5952C008F
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2012 08:30:43 +1100 (EST)
Subject: Re: [PATCH] Revert "crypto: caam - Updated SEC-4.0 device tree
 binding for ERA information."
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1354870649-3656-1-git-send-email-vakul@freescale.com>
Date: Wed, 12 Dec 2012 15:29:58 -0600
Message-Id: <C38A27FC-51EF-44F3-8474-33162DE1A272@kernel.crashing.org>
References: <1354870649-3656-1-git-send-email-vakul@freescale.com>
To: Vakul Garg <vakul@freescale.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2012, at 2:57 AM, Vakul Garg wrote:

> This reverts commit a2c0911c09190125f52c9941b9d187f601c2f7be.
> 
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> Instead of adding SEC era information in crypto node's compatible, a new
> property 'fsl,sec-era' is being introduced into crypto node.
> 
> .../devicetree/bindings/crypto/fsl-sec4.txt        |    5 ++---
> 1 files changed, 2 insertions(+), 3 deletions(-)

What tree do you think this has been applied to?

- k
