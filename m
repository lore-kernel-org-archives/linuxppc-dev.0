Return-Path: <R1AAHA@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CA022C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 08:11:19 +1100 (EST)
Received: from mail142-tx2 (localhost [127.0.0.1])	by
 mail142-tx2-R.bigfish.com (Postfix) with ESMTP id 23AA22401EE	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 21:11:15 +0000 (UTC)
Received: from TX2EHSMHS008.bigfish.com (unknown [10.9.14.240])	by
 mail142-tx2.bigfish.com (Postfix) with ESMTP id E200044004F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 21:11:13 +0000 (UTC)
Date: Tue, 2 Apr 2013 16:07:50 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <vakul@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/85xx: add SEC-5.3 device tree
Message-ID: <20130402160750.4a9ff6e8ce983080ebceca74@freescale.com>
In-Reply-To: <1364886874-9580-1-git-send-email-vakul@freescale.com>
References: <1364886874-9580-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Shaveta Leekha <shaveta@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2 Apr 2013 12:44:34 +0530
<vakul@freescale.com> wrote:

threading seems broken between patches 1 & 2...

> +crypto: crypto@300000 {
> +	compatible = "fsl,sec-v5.3", "fsl,sec-v5.0", "fsl,sec-v4.0";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	reg		 = <0x300000 0x10000>;
> +	ranges		 = <0 0x300000 0x10000>;
> +	interrupts	 = <92 2 0 0>;

what, no fsl,era? :)

Kim
