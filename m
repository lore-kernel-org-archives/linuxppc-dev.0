Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 049F02C00B7
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 07:07:41 +1000 (EST)
Date: Wed, 18 Jul 2012 14:07:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
Message-Id: <20120718140738.ca6f8f5a.akpm@linux-foundation.org>
In-Reply-To: <CAMuHMdWW=sAff-iw0EiHaejr34Z4u_X7w3nHf6Tfo-c2f=Qijg@mail.gmail.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
 <20120620161249.GB29196@linux-mips.org>
 <4FE4B13E.10709@caviumnetworks.com>
 <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
 <CAMuHMdWW=sAff-iw0EiHaejr34Z4u_X7w3nHf6Tfo-c2f=Qijg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, David Daney <ddaney@caviumnetworks.com>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mundt <lethal@linux-sh.org>,
 Chris Zankel <chris@zankel.net>, Yoichi Yuasa <yuasa@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2012 10:35:46 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, Jul 16, 2012 at 9:27 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jun 22, 2012 at 7:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> >> On 06/20/2012 09:12 AM, Ralf Baechle wrote:
> >>>
> >>> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
> >>>
> >>>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
> >>>
> >>>
> >>> Thanks, fix applied.
> >>>
> >>
> >> Where was it applied?
> >>
> >> It doesn't show up in linux-next for 20120622, which is where it is needed.
> >
> > It's also desperately needed in mainline for 3.5.
> >
> > Ralf?
> 
> Andrew? This prevents any green MIPS builds.
> 

The patch is already in linux-next via Ralf's tree.

Perhaps he nodded off - I'll send it at Linus right now.
