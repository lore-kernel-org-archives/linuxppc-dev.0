Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 303071A074A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:26:58 +1000 (AEST)
Message-ID: <1428956804.22867.632.camel@freescale.com>
Subject: Re: [v3, 01/11] powerpc/8xx: remove remaining unnecessary code in
 FixupDAR
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Mon, 13 Apr 2015 15:26:44 -0500
In-Reply-To: <552A9A5D.4070208@c-s.fr>
References: <20150203113816.E77811A5F13@localhost.localdomain>
 <20150326213215.GA21815@home.buserror.net> <552A9A5D.4070208@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-04-12 at 18:16 +0200, leroy christophe wrote:
> 
> Le 26/03/2015 22:32, Scott Wood a écrit :
> > On Tue, Feb 03, 2015 at 12:38:16PM +0100, LEROY Christophe wrote:
> >> Since commit 33fb845a6f01 ("powerpc/8xx: Don't use MD_TWC for walk"), MD_EPN and
> >> MD_TWC are not writen anymore in FixupDAR so saving r3 has become useless.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >> v2: no change
> >> v3: no change
> > This doesn't apply cleanly.
> >
> >
> You already applied part of that patchset it in your next tree, 
> including that one (commit 2374d0a).
> You told me to re-submit a patchset with only the remaining ones, 
> therefore I sent v4 on the 4th of Feb, based on your tree.

OK.  I applied v2, and didn't remember that when I came across v3 in
patchwork.

-Scott
