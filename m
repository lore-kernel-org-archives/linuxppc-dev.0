Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424SYK063lzF3R6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 23:36:52 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so6761664oip.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 06:36:52 -0700 (PDT)
Message-ID: <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
From: Rob Herring <robh@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Leo Li <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831035219.31619-2-ran.wang_1@nxp.com>
Date: Mon, 3 Sep 2018 20:25:18 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2018 at 11:52:18AM +0800, Ran Wang wrote:
> Add property 'big-endian' and supportted IP's configuration info.
> Remove property 'fsl,#rcpm-wakeup-cell'.

"dt-bindings: soc: ..." for the subject

It is obvious reading the diff you are removing fsl,#rcpm-wakeup-cell. 
What is not obvious is why? The commit msg should answer that.

You also are mixing several things in this patch like adding ls1012 
which you don't mention. Please split.

> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   42 ++++++-------------
>  1 files changed, 13 insertions(+), 29 deletions(-)
