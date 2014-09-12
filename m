Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C7E11A0026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 18:34:24 +1000 (EST)
Message-ID: <1410510864.17540.11.camel@concordia>
Subject: Re: [PATCH] powerpc: make of_device_ids const
From: Michael Ellerman <mpe@ellerman.id.au>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 12 Sep 2014 18:34:24 +1000
In-Reply-To: <1410378998-8823-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410378998-8823-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, kernel@pengutronix.de,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-10 at 21:56 +0200, Uwe Kleine-König wrote:
> of_device_ids (i.e. compatible strings and the respective data) are not
> supposed to change at runtime. All functions working with of_device_ids
> provided by <linux/of.h> work with const of_device_ids. This allows to
> mark all struct of_device_id const, too.
> 
> While touching these line also put the __init annotation at the right
> position where necessary.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I don't know how arch/powerpc is maintained. So please tell me if I
> should split this patch further.
> 
> I manually checked that all const annotations are OK, and the 0day build
> bot didn't find a regression.

Thanks.

We'll take it as-is, it seems to merge cleanly.

We track patches via patchwork, this one is at:
  http://patchwork.ozlabs.org/patch/387959/

cheers
