Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2923C2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 17:58:17 +1100 (EST)
Message-ID: <1389077881.11795.137.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] powerpc/85xx: handle the eLBC error interrupt if it
 exist in dts
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 7 Jan 2014 00:58:01 -0600
In-Reply-To: <1389076061-20159-1-git-send-email-dongsheng.wang@freescale.com>
References: <1389076061-20159-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-07 at 14:27 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>

AFAICT this patch was originally written by Shaohui Xie.

> On P3041, P1020, P1021, P1022, P1023 eLBC event interrupts are routed
> to Int9(P3041) & Int3(P102x) while ELBC error interrupts are routed to
> Int0, we need to call request_irq for each.

For p3041 I thought that was only on early silicon revs that we don't
support anymore.

As for p102x, have you tested that this is actually what happens?  How
would we distinguish eLBC errors from other error sources, given that
there's no EISR0?  Do we just hope that no other error interrupts
happen?

-Scott
