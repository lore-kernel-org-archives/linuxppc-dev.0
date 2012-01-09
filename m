Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F2B2FB6F74
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 07:55:12 +1100 (EST)
Message-ID: <4F0B541C.1050001@freescale.com>
Date: Mon, 9 Jan 2012 14:54:52 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Xu Jiucheng <B37781@freescale.com>
Subject: Re: [SDK v1.2][PATCH 1/2 v3] powerpc/85xx: Add dts for P1021RDB-PC
 board
References: <1326092022-10085-1-git-send-email-B37781@freescale.com>
In-Reply-To: <1326092022-10085-1-git-send-email-B37781@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 12:53 AM, Xu Jiucheng wrote:
> +	nand@1,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,p1020-fcm-nand",
> +			     "fsl,elbc-fcm-nand";

s/p1020/p1021/

-Scott
