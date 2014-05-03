Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 81AB014016C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 10:31:27 +1000 (EST)
Date: Fri, 2 May 2014 19:31:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: harninder rai <harninder.rai@freescale.com>
Subject: Re: powerpc/mpc85xx: Add BSC9132 QDS Support
Message-ID: <20140503003113.GB20757@home.buserror.net>
References: <1395128102-12983-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1395128102-12983-1-git-send-email-harninder.rai@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ruchika Gupta <ruchika.gupta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2014 at 01:05:02PM +0530, harninder rai wrote:
> +&ifc {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	compatible = "fsl,ifc", "simple-bus";
> +	/* FIXME: Test whether interrupts are split */
> +	interrupts = <16 2 0 0 20 2 0 0>;
> +};

Have you done this test yet?

-Scott
