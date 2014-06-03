Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E98A01A0041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 02:12:52 +1000 (EST)
Message-ID: <1401811959.6603.287.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: Add T4240RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <b25806@freescale.com>
Date: Tue, 3 Jun 2014 11:12:39 -0500
In-Reply-To: <538D8E15.5070506@freescale.com>
References: <1401264681-30058-1-git-send-email-Chunhe.Lan@freescale.com>
 <1401485104.6603.221.camel@snotra.buserror.net>
 <538D8E15.5070506@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-03 at 16:57 +0800, Chunhe Lan wrote:
> On 05/31/2014 05:25 AM, Scott Wood wrote:
> > On Wed, 2014-05-28 at 16:11 +0800, Chunhe Lan wrote:
> >> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> >> index 8e4b1e1..2f50526 100644
> >> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> >> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> >> @@ -119,6 +119,7 @@ static const char * const boards[] __initconst = {
> >>   	"fsl,P5020DS",
> >>   	"fsl,P5040DS",
> >>   	"fsl,T4240QDS",
> >> +	"fsl,T4240RDB",
> >>   	"fsl,B4860QDS",
> >>   	"fsl,B4420QDS",
> >>   	"fsl,B4220QDS",
> > What about hv_boards?
>      Does not have hv boards. So does not support hv.

This isn't about a physical "hv board".  Topaz appends -hv to the board
compatible.  I wish we had just made a single "Topaz e500 platform" like
we did for qemu e500, but oh well.

-Scott
