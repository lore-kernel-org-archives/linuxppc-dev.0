Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B45D2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 06:48:09 +1100 (EST)
Message-ID: <1386876720.10013.260.camel@snotra.buserror.net>
Subject: Re: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
From: Scott Wood <scottwood@freescale.com>
To: Sinan Akman <sinan@writeme.com>
Date: Thu, 12 Dec 2013 13:32:00 -0600
In-Reply-To: <52A9F685.3040204@writeme.com>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
 <52A9E074.5080607@sirius-es.it> <52A9F685.3040204@writeme.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Gerhard Sittig <gsi@denx.de>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-12 at 18:46 +0100, Sinan Akman wrote:
> Matteo Facchinetti wrote:
> > [...]
> > - NFC: one of the biggest unsolved mystery
> > Is this ip-core used in others microcontrollers? Seems to be used only 
> > in mpc5125!!!
> I don't think that IP is used in any other FSL SoC. Scott can probably
> confirm this for us.

That's a different part of Freescale, so I don't know much about it, but
it looks pretty similar to MXC NAND.  Back when those drivers were
submitted I tried to get the authors of each to work together to see if
a common driver made sense, but I got little response.

-Scott
