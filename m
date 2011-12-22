Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 53E11B71A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 05:11:45 +1100 (EST)
Received: from mail181-ch1 (localhost [127.0.0.1])	by
 mail181-ch1-R.bigfish.com (Postfix) with ESMTP id 6B28C4201EA	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 18:12:05 +0000 (UTC)
Received: from CH1EHSMHS012.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])	by mail181-ch1.bigfish.com (Postfix) with ESMTP id
 1A09C40042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 18:12:04 +0000 (UTC)
Message-ID: <4EF372D5.3010404@freescale.com>
Date: Thu, 22 Dec 2011 12:11:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v3 4/4] fsl_pmc: update device bindings
References: <1324554214-19502-1-git-send-email-chenhui.zhao@freescale.com>
 <1324554214-19502-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1324554214-19502-4-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/22/2011 05:43 AM, Zhao Chenhui wrote:
>    Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
> -  bit assignments are indicated via the sleep specifier in each device's
> -  sleep property.
> +  bit assignments are indicated via the clock nodes.  Device which has a
> +  controllable clock source should have a "clk-handle" property pointing
> +  to the clock node.

fsl,pmc-handle

>  - reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
>    is the PMC block, and the second resource is the Clock Configuration
>    block.
>  
> -  For devices compatible with "fsl,mpc8548-pmc", the first resource
> -  is a 32-byte block beginning with DEVDISR.
> +  For devices compatible with "fsl,mpc8548-pmc", the second resource
> +  is a 32-byte block beginning with DEVDISR if supported.

What's going on here?

-Scott
