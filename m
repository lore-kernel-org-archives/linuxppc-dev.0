Return-Path: <SRS0=9/fIer=VU=writeme.com=sinan@yourhostingaccount.com>
Received: from mailout07.yourhostingaccount.com
 (mailout07.yourhostingaccount.com [65.254.253.58])
 by ozlabs.org (Postfix) with ESMTP id 1F7862C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 12:00:16 +1100 (EST)
Received: from mailscan16.yourhostingaccount.com ([10.1.15.16]
 helo=mailscan16.yourhostingaccount.com)
 by mailout07.yourhostingaccount.com with esmtp (Exim)
 id 1VrGdh-0005J3-C0
 for linuxppc-dev@lists.ozlabs.org; Thu, 12 Dec 2013 19:29:57 -0500
Message-ID: <52AA54F5.5030909@writeme.com>
Date: Fri, 13 Dec 2013 01:29:41 +0100
From: Sinan Akman <sinan@writeme.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
References: <1386681097-14126-1-git-send-email-gsi@denx.de>	
 <52A9E074.5080607@sirius-es.it> <52A9F685.3040204@writeme.com>
 <1386876720.10013.260.camel@snotra.buserror.net>
In-Reply-To: <1386876720.10013.260.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Sinan Akman <sinan@writeme.com>
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

Scott Wood wrote:
> On Thu, 2013-12-12 at 18:46 +0100, Sinan Akman wrote:
>> Matteo Facchinetti wrote:
>>> [...]
>>> - NFC: one of the biggest unsolved mystery
>>> Is this ip-core used in others microcontrollers? Seems to be used only 
>>> in mpc5125!!!
>> I don't think that IP is used in any other FSL SoC. Scott can probably
>> confirm this for us.
> 
> That's a different part of Freescale, so I don't know much about it, but
> it looks pretty similar to MXC NAND.  Back when those drivers were
> submitted I tried to get the authors of each to work together to see if
> a common driver made sense, but I got little response.

   OK Scott thanks for your comments. I am somewhat deep in 5125 NFC. I will
take a look at mxc nand and see how similar they are. Who is maintaining
mxc nand ? I might spend some time and create some common components.
But right now I am not familiar with mxc nand.

   Thanks

   Sinan Akman
