Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xysrx3vN5zDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 09:14:57 +1000 (AEST)
Received: by mail-pg0-f65.google.com with SMTP id j16so4197032pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 16:14:57 -0700 (PDT)
Date: Thu, 21 Sep 2017 18:14:52 -0500
From: Rob Herring <robh@kernel.org>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, arnd@arndb.de,
 madalin.bucur@nxp.com, catalin.marinas@arm.com,
 linux@armlinux.org.uk, oss@buserror.net
Subject: Re: [v5 04/12] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
Message-ID: <20170921231452.if6soolp6tzawbmx@rob-hp-laptop>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 04:39:39PM -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatible with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++++++++++++++------
>  2 files changed, 26 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
