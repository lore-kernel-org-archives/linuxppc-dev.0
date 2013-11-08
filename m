Return-Path: <guangyu.chen@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC9F42C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 22:31:34 +1100 (EST)
Date: Fri, 8 Nov 2013 19:29:20 +0800
From: Nicolin Chen <b42378@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <s.hauer@pengutronix.de>, <timur@tabi.org>, <shawn.guo@linaro.org>,
 <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
Message-ID: <20131108112919.GA5159@MrMyself>
References: <cover.1383907685.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1383907685.git.b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, swarren@wwwdotorg.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, dmaengine@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 08, 2013 at 06:49:32PM +0800, Nicolin Chen wrote:
>  * ! This series of patches has a direct dependency between them. When
>  * ! applying them, we need to apply to one single branch. Otherwise,
>  * ! it would break currect branches.
> 
> Changelog
> v4:
>  * PATCH-3: Add period size constraint when using dual fifo mode
>  *
>  * Nothing changes for PATCH-1, PATCH-2 and PATCH-4


Sorry all, I mistook the version number. It should be version 5.

Please ignore this series version.

I'll resend v5 soon.

Nicolin Chen
