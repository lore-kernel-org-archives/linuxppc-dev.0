Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Lzb48G8zF3Qf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 04:25:31 +1000 (AEST)
Received: by mail-yw0-f193.google.com with SMTP id u124-v6so6642319ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 11:25:31 -0700 (PDT)
Date: Mon, 11 Jun 2018 12:25:27 -0600
From: Rob Herring <robh@kernel.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3, 03/10] dt-binding: ptp_qoriq: add DPAA FMan support
Message-ID: <20180611182527.GA13639@rob-hp-laptop>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
 <20180607092050.46128-4-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180607092050.46128-4-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2018 at 05:20:43PM +0800, Yangbo Lu wrote:
> This patch is to add bindings description for DPAA
> FMan 1588 timer, and also remove its description in
> fsl-fman dt-bindings document.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None.
> Changes for v3:
> 	- None.
> ---
>  Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-------------------
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++++++++--
>  2 files changed, 13 insertions(+), 27 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
