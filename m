Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxbvr3R8LzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 01:42:32 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id f193so20277279oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 08:42:32 -0700 (PDT)
Date: Mon, 3 Apr 2017 10:42:29 -0500
From: Rob Herring <robh@kernel.org>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: robin.murphy@arm.com, oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 madalin.bucur@nxp.com
Subject: Re: [RFC PATCH 4/5] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
Message-ID: <20170403154229.mf63zeiwv5naxyrr@rob-hp-laptop>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 29, 2017 at 05:13:56PM -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatiable with

s/compatiable/compatible/

> the shared-dma-pool usage.

This change is not backwards compatible. Please state that and explain 
why that is okay. If PPC needs to not change, then the old strings and 
properties should remain, but deprecated.

> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 10 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 16 +++++++++-------
>  2 files changed, 14 insertions(+), 12 deletions(-)
