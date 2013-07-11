Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A1CB2C0322
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 00:35:15 +1000 (EST)
Date: Thu, 11 Jul 2013 09:35:02 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOg==?= [PATCH] Powerpc/t4240: change the
 compatible flags for t4240qds board
To: Zhang Haijun-B42677 <B42677@freescale.com>
References: <99E897753B6F7048BD8CCDB4661D02E1396F57@039-SN2MPN1-021.039d.mgd.msft.net>
 <1373400262.8183.201@snotra>
 <99E897753B6F7048BD8CCDB4661D02E139CE27@039-SN2MPN1-021.039d.mgd.msft.net>
 <1373488205.8183.228@snotra>
 <99E897753B6F7048BD8CCDB4661D02E139E033@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E139E033@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B42677@freescale.com on Wed Jul 10 20:02:31 2013)
Message-ID: <1373553302.8183.246@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Xie Xiaobo-R63061 <r63061@freescale.com>,
 Wrobel Heinz-R39252 <r39252@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 08:02:31 PM, Zhang Haijun-B42677 wrote:
> > Also make sure that you only do this for quirks that are actually =20
> board-
> > specific.  In your last patch you had two quirks keyed off of the =20
> board,
> > one of which is keyed off of the SoC for other chips.
> >
> [Haijun Wrote:] Actually there are only one board with T4240 Soc.

What about customer boards?  In any case, it's not a reason to look for =20
the wrong thing.

-Scott=
