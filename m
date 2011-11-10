Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7F7981007D8
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 05:11:37 +1100 (EST)
Date: Thu, 10 Nov 2011 12:10:47 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 28/30] powerpc/85xx: Rework P1023RDS device tree
Message-ID: <20111110181047.GB12203@schlenkerla.am.freescale.net>
References: <1320941653-29797-20-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-21-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-22-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-23-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-24-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-25-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-26-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-27-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-28-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-29-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1320941653-29797-29-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 10:14:11AM -0600, Kumar Gala wrote:
> -		power@e0070{
> -			compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc",
> -			             "fsl,p1022-pmc";
> -			reg = <0xe0070 0x20>;
> -			etsec1_clk: soc-clk@B0{
> -				fsl,pmcdr-mask = <0x00000080>;
> -			};
> -			etsec2_clk: soc-clk@B1{
> -				fsl,pmcdr-mask = <0x00000040>;
> -			};
> -			etsec3_clk: soc-clk@B2{
> -				fsl,pmcdr-mask = <0x00000020>;
> -			};
> -		};

The compatibles on this node are wrong, but it looks like you're removing
it altogether?

-Scott
