Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76EC31A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 01:02:08 +1100 (AEDT)
Message-ID: <5452445F.7090803@Freescale.com>
Date: Thu, 30 Oct 2014 08:59:59 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Igal.Liberman <igal.liberman@Freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Added rcw registers to global utility registers
References: <1414660547-1488-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1414660547-1488-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="windows-1252"
Cc: scottwood@Freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/30/2014 04:15 AM, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> The RCW registers are required for the future clock binding implementation.
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> Change-Id: Ic36dd8bc2959aa7f97fb6fd7bbb8420822fef0a9
> ---
>  arch/powerpc/include/asm/fsl_guts.h |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>


Cheers,
