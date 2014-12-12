Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E62B61A09D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Dec 2014 08:10:46 +1100 (AEDT)
Message-ID: <1418418631.5581.68.camel@freescale.com>
Subject: Re: [Patch] :Fix ISR return value in i2c-mpc.c
From: Scott Wood <scottwood@freescale.com>
To: Amit Tomar <Amit.Tomar@freescale.com>
Date: Fri, 12 Dec 2014 15:10:31 -0600
In-Reply-To: <BL2PR03MB4496E03E1930685FD2A4FD483600@BL2PR03MB449.namprd03.prod.outlook.com>
References: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
 <BL2PR03MB4496E03E1930685FD2A4FD483600@BL2PR03MB449.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-12 at 11:17 +0000, Amit Tomar wrote:
> In current scenario, ISR of i2c-mpc.c is returning IRQ_HANDLED for doing nothing which is not right .
> 
> With below patch ISR now return IRQ_NONE for doing nothing and IRQ_HANDLED for doing handler work.

Wrap the commit message at around 65-70 characters, change the subject
to "[PATCH] i2c/mpc: Fix ISR return value", and send to the proper
mailing list/maintainers for i2c (see the MAINTAINERS file).

-Scott
