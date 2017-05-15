Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wRNKp4dFqzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 00:30:52 +1000 (AEST)
Date: Mon, 15 May 2017 10:30:48 -0400 (EDT)
Message-Id: <20170515.103048.248884533404807350.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, oss@buserror.net,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: move FMan binding
From: David Miller <davem@davemloft.net>
In-Reply-To: <1494855398-26215-1-git-send-email-madalin.bucur@nxp.com>
References: <1494855398-26215-1-git-send-email-madalin.bucur@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Mon, 15 May 2017 16:36:38 +0300

> Besides the PPC SoCs, the QorIQ DPAA FMan is also present on ARM SoCs,
> moving the device tree binding document into the bindings/net folder.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

What tree is this targetted at for merging?
