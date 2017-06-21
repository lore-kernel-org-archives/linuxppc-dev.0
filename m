Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtLvj1p1tzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 09:46:25 +1000 (AEST)
Date: Wed, 21 Jun 2017 16:46:21 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 2/4] of: make __of_attach_node() static
Message-ID: <20170621234621.GL4493@codeaurora.org>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
 <1497996172-821-3-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497996172-821-3-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> __of_attach_node() is not used outside of drivers/of/dynamic.c.  Make
> it static and remove it from drivers/of/of_private.h.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
