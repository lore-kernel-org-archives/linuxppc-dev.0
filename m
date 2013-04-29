Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6E3DB2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 05:50:57 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl-booke: add the reg property for pci bridge
 device node for t4/b4xx boards
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365918013-12190-1-git-send-email-haokexin@gmail.com>
Date: Mon, 29 Apr 2013 14:50:51 -0500
Message-Id: <258B986A-A498-4B5A-93C4-C26EA3034E7B@kernel.crashing.org>
References: <1365918013-12190-1-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 14, 2013, at 12:40 AM, Kevin Hao wrote:

> The reg property in the pci bridge device node is used to bind this
> device node to the pci bridge device. Then all the pci devices under
> this bridge could use the interrupt maps defined in this device node
> to do the irq translation. So if this property is missed, the pci
> traditional irq mechanism will not work.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 1 +
> arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 ++++
> 2 files changed, 5 insertions(+)

applied to next

- k
