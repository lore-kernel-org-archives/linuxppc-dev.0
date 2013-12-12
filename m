Return-Path: <SRS0=DU4bu5=VT=writeme.com=sinan@yourhostingaccount.com>
Received: from mailout15.yourhostingaccount.com
 (mailout15.yourhostingaccount.com [65.254.253.125])
 by ozlabs.org (Postfix) with ESMTP id 06A752C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 05:19:57 +1100 (EST)
Received: from mailscan13.yourhostingaccount.com ([10.1.15.13]
 helo=mailscan13.yourhostingaccount.com)
 by mailout15.yourhostingaccount.com with esmtp (Exim)
 id 1VrANU-0005q3-KQ
 for linuxppc-dev@lists.ozlabs.org; Thu, 12 Dec 2013 12:48:48 -0500
Message-ID: <52A9F685.3040204@writeme.com>
Date: Thu, 12 Dec 2013 18:46:45 +0100
From: Sinan Akman <sinan@writeme.com>
MIME-Version: 1.0
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
 <52A9E074.5080607@sirius-es.it>
In-Reply-To: <52A9E074.5080607@sirius-es.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: Sinan Akman <sinan@writeme.com>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Gerhard Sittig <gsi@denx.de>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matteo Facchinetti wrote:
> [...]
> - NFC: one of the biggest unsolved mystery
> Is this ip-core used in others microcontrollers? Seems to be used only 
> in mpc5125!!!
I don't think that IP is used in any other FSL SoC. Scott can probably
confirm this for us.

I did some digging on this NFC just to put enough things together
that I can erase and flash firmware using BDI3000 that is read and
executed properly when the boot flag is set.

Do you see any other anomalies with MPC5125 NFC ?

Thanks

Sinan Akman
