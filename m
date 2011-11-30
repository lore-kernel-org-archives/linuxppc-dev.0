Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CA697B6F76
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 15:41:00 +1100 (EST)
Message-ID: <1322628047.21641.31.camel@pasglop>
Subject: Re: [PATCH 00/10] powerpc/mpic: General cleanup patch series
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Date: Wed, 30 Nov 2011 15:40:47 +1100
In-Reply-To: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-29 at 13:58 -0500, Kyle Moffett wrote:
> Hello,
> 
> As BenH requested, this is the version-2 repost of the PowerPC MPIC
> cleanup patch series.
> 
> All of the review comments have been addressed, and I have performed
> build and boot testing on our HWW-1U-1A hardware with these patches
> applied (plus a few independent board-support patches).
> 
> Unfortunately, this has a potentially very broad impact across a wide
> variety of hardware that I don't have the ability to test with, so
> any additional testing will be highly appreciated.  Ben has indicated
> that he plans to put it into his testing tree soon, so hopefully any
> such issues will get ironed out quickly.

Ok, clashes with whatever I already have in -next, so I did a manual
merge in my -test branch, please double check I haven't done any
mistake. (This test branch also contains Becky current patch series).

So -test is out there for you guys to hammer on, I'll do some tests
myself in the next couple of days, and I expect to merge all of that
into -next (assuming there are no big issues) some time next week.

BTW. Reminder to all: -test is a rebase-friendly branch, so pull -f and
do NOT base any work on top of it if you aren't ready to deal with your
origin changing completely from underneath you.

Cheers,
Ben.
