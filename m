Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BF632C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 12:06:41 +1100 (EST)
Message-ID: <1390007187.24905.293.camel@snotra.buserror.net>
Subject: Re: [PATCH v9] clk: corenet: Adds the clock binding
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Date: Fri, 17 Jan 2014 19:06:27 -0600
In-Reply-To: <1389600995-28293-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1389600995-28293-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, b07421@freescale.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-13 at 16:16 +0800, Tang Yuantian wrote:
> +Example for clock block and clock provider:
> +/ {
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +		ranges = <0x0 0xe1000 0x1000>;
> +		clock-frequency = 133333;

Missing <> around 133333, and the actual p5020ds input clock (based on
observing what U-Boot fills in) is 133333333, not 133333.

I'll fix when applying.

-Scott
