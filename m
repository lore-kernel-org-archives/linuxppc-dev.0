Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67AC91A0118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 01:47:27 +1100 (AEDT)
Message-ID: <1414680434.23458.144.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Added rcw registers to global utility registers
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 30 Oct 2014 09:47:14 -0500
In-Reply-To: <5452445F.7090803@Freescale.com>
References: <1414660547-1488-1-git-send-email-igal.liberman@freescale.com>
 <5452445F.7090803@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "Igal.Liberman" <igal.liberman@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-30 at 08:59 -0500, Emil Medve wrote:
> On 10/30/2014 04:15 AM, Igal.Liberman wrote:
> > From: Igal Liberman <Igal.Liberman@freescale.com>
> > 
> > The RCW registers are required for the future clock binding implementation.
> > 
> > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > Change-Id: Ic36dd8bc2959aa7f97fb6fd7bbb8420822fef0a9
> > ---
> >  arch/powerpc/include/asm/fsl_guts.h |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

How were you involved in the patch or its submission?  Did you mean
Reviewed-by or similar?

-Scott
