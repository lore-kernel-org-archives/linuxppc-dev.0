Return-Path: <marc@tensilica.com>
Received: from mailgw.tensilica.com (mailgw.tensilica.com [65.119.96.134])
 by ozlabs.org (Postfix) with ESMTP id C04122C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 07:57:02 +1000 (EST)
From: Marc Gauthier <marc@tensilica.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 2 Oct 2012 14:33:46 -0700
Subject: RE: [LKML] Re: Build regressions/improvements in v3.6
Message-ID: <522C1DF17AF50042AD8AE87F7887BD3D05BF604843@exch.hq.tensilica.com>
References: <1349202763-1601-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXcMVkcqTJdH2zdo9=a2efeeQmPGUr9GZqRMuRrAuMBvw@mail.gmail.com>
In-Reply-To: <CAMuHMdXcMVkcqTJdH2zdo9=a2efeeQmPGUr9GZqRMuRrAuMBvw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Chris Zankel <chris@zankel.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Max Filippov <jcmvbkbc@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> xtensa-allmodconfig (hmm, this is not a new one, it felt through the
> cracks in -rc7 because of log line interleaving).
>
> Ugh, arch/xtensa/include/asm/regs.h defines way to generic symbols,
> like "MISC" (which causes the above breakage), and even a few
> 2-letter symbols, which surprisingly don't cause conflicts...

This particular one is already fixed in the xtensa linux-next tree
at git://github.com/czankel/xtensa-linux.git#for_next
(commit 36c74c2a16678e9ee6f08ef89eeebfdd1a96693d).

The short names in that header are for historical reasons.
It is indeed due for a cleanup.

-Marc
