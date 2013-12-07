Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 025252C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:40:19 +1100 (EST)
Date: Sat, 7 Dec 2013 10:40:12 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 05/17] clk: mpc512x: add backwards compat to the CCF
 code
Message-ID: <20131207104012.6d544844@crub>
In-Reply-To: <1385851897-23475-6-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-6-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Turquette <mturquette@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:25 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> extend the recently added COMMON_CLK platform support for MPC512x such
> that it works with incomplete device tree data which lacks clock specs
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/platforms/512x/clock-commonclk.c |  173 ++++++++++++++++++++++++-
>  1 file changed, 172 insertions(+), 1 deletion(-)

moved node macro definitions out of the function body and applied
to next. Thanks!

Anatolij
