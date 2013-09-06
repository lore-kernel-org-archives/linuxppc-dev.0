Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 823462C010C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:26:16 +1000 (EST)
Message-ID: <1378481093.12204.182.camel@snotra.buserror.net>
Subject: Re: [PATCH V3 1/2] powerpc/85xx: Add QE common init functions
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>
Date: Fri, 6 Sep 2013 10:24:53 -0500
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D5D2378@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378312019.12204.21.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5D2378@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-06 at 04:52 -0500, Xie Xiaobo-R63061 wrote:
> Hi Scott,
> 
> I already remove these code from the P1025TWR platform file(see the 2/2 patch). Do you means I also need to remove these codes from the others platforms and use the common call instead? 
> Thank you.

Yes.

-Scott
