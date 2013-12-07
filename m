Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 237522C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:32:59 +1100 (EST)
Date: Sat, 7 Dec 2013 10:32:49 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 02/17] dts: mpc512x: introduce dt-bindings/clock/ header
Message-ID: <20131207103249.7c7fd976@crub>
In-Reply-To: <1385851897-23475-3-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-3-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:22 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> introduce a dt-bindings/ header file for MPC512x clocks,
> providing symbolic identifiers for those SoC clocks which
> clients will reference from their device tree nodes
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mike Turquette <mturquette@linaro.org>	# for v3: w/o bdlc, PSC ipg
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  include/dt-bindings/clock/mpc512x-clock.h |   69 +++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mpc512x-clock.h

applied to next. Thanks!

Anatolij
