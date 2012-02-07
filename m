Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F296B71AB
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2012 06:25:52 +1100 (EST)
Message-ID: <4F317AB1.7080208@freescale.com>
Date: Tue, 7 Feb 2012 13:25:37 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl: add PAMUBYPENR register definition to
 fsl_guts.h
References: <1328555872-9616-1-git-send-email-timur@freescale.com>
 <Pine.LNX.4.64.1202071221150.22169@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.64.1202071221150.22169@gate.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> What code will use this?  Once such code exists, have this patch in that
> patch series.

Isn't this patch harmless?  I'm not adding any code, and there already are
plenty of fields defined in that struct that aren't used anywhere.

The register is for the PAMU driver, which is nowhere near ready for
upstream anyway.  I was hoping to get the this patch in the pipeline ahead
of schedule.

So if you don't mind, I'd like you to consider this patch as-is.

-- 
Timur Tabi
Linux kernel developer at Freescale
