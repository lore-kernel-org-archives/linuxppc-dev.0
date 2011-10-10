Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id 025D2B70B7
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2011 03:29:16 +1100 (EST)
Date: Mon, 10 Oct 2011 18:29:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Dan Malek <ppc6dev@digitaldans.com>
Subject: Re: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
Message-ID: <20111010162909.GB21699@1wt.eu>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi an,

On Mon, Oct 10, 2011 at 09:22:09AM -0700, Dan Malek wrote:
> 
> Hi Joakim.
> 
> On Oct 10, 2011, at 4:38 AM, Joakim Tjernlund wrote:
> 
> >This adds Large page support for 8xx and uses it
> >for all kernel RAM....
> 
> >- Dan, what do you think :)
> 
> Since you asked, yes it looks great :-)  Now, can we
> get this into a more contemporary kernel?  I'm
> actually working on an 8xx project that may have
> a few years of life left.

At the pace of current 2.4, I'm sure the code won't have change
much a few years from now :-) It would be nice to know by now if
the current longterm branches work OK or not though.

Cheers,
Willy
