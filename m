Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL0lc2fbzzDt08
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 01:30:36 +1100 (AEDT)
Received: by mail-oi0-f66.google.com with SMTP id v84so10947091oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:30:36 -0800 (PST)
Date: Fri, 18 Nov 2016 08:30:32 -0600
From: Rob Herring <robh@kernel.org>
To: Florian Larysch <fl@n621.de>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] DT: i2c: W83793 is a trivial device
Message-ID: <20161118143032.qupvnq5clbgnlpni@rob-hp-laptop>
References: <20161117102324.18319-1-fl@n621.de>
 <20161117102324.18319-3-fl@n621.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161117102324.18319-3-fl@n621.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2016 at 11:23:24AM +0100, Florian Larysch wrote:
> Signed-off-by: Florian Larysch <fl@n621.de>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
