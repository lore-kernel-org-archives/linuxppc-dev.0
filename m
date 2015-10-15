Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A9F41A0427
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 16:31:48 +1100 (AEDT)
Date: Thu, 15 Oct 2015 16:29:55 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Laurentiu Tudor <b10716@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 Scott Wood <scottwood@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc/e6500: add TMCFG0 register definition
Message-ID: <20151015052955.GC2960@iris.ozlabs.ibm.com>
References: <5602BFEE.7060708@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5602BFEE.7060708@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 23, 2015 at 06:06:22PM +0300, Laurentiu Tudor wrote:
> The register is not currently used in the base kernel
> but will be in a forthcoming kvm patch.
> 
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.
