Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B16F71A0288
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 20:16:46 +1100 (EST)
Message-ID: <1413278182.2878.8.camel@aoeu.buserror.net>
Subject: Re: [PATCH v3 00/21] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Tue, 14 Oct 2014 11:16:22 +0200
In-Reply-To: <543C0176.5050706@c-s.fr>
References: <20140917163656.E09D81AB026@localhost.localdomain>
 <1410972043.24184.532.camel@snotra.buserror.net> <5419F017.8010603@c-s.fr>
 <1410986079.24184.534.camel@snotra.buserror.net> <543C0176.5050706@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-13 at 18:44 +0200, leroy christophe wrote:
> Le 17/09/2014 22:34, Scott Wood a écrit :
> > On Wed, 2014-09-17 at 22:33 +0200, christophe leroy wrote:
> >> Le 17/09/2014 18:40, Scott Wood a écrit :
> >>> On Wed, 2014-09-17 at 18:36 +0200, Christophe Leroy wrote:
> >>>> This patchset:
> >>>> 1) provides several MMU TLB handling optimisation on MPC8xx.
> >>>> 2) adds support of 16k pages on MPC8xx.
> >>>> All changes have been successfully tested on a custom board equipped with MPC885
> >>>>
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>>> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>> I've already applied patches 1, 2, 4, 5, 6, 9, and 10 from the previous
> >>> patchset -- have they changed?
> >>>
> >>> -Scott
> >>>
> >> No, only 3, 7, 17 are changed, and 20,21 are new.
> >> I didn't notice you already applied some. How should I then proceed now
> >> for the remaining ones ? Submit a new set ?
> >>
> > No, I'll just skip the ones I've already applied.
> >
> >
> I think I took into account all Joakim's and your's comments in v4.
> Since I submitted v4, I think I didn't get any new comment.
> What's the way forward to get the remaining ones applied ?

I haven't had a chance to review v4 yet.  I'm currently at conferences
and will be on vacation next week, but I will try to look at them soon
after that.

-Scott
