Date: Thu, 27 May 2004 07:40:10 -0700
From: Larry McVoy <lm@bitmover.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem with bitkeeper?
Message-ID: <20040527144010.GA3375@work.bitmover.com>
References: <40B5B3EC.3000709@intracom.gr> <Pine.GSO.4.58.0405271206490.17038@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0405271206490.17038@waterleaf.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, May 27, 2004 at 12:07:18PM +0200, Geert Uytterhoeven wrote:
>
> On Thu, 27 May 2004, Pantelis Antoniou wrote:
> > Is anyone else having problems pulling today from
> > from ppc.bkbits.net (using http)?
>
> bkbits.net is down, cfr. a posting from Larry on lkml.

It's fixed.  It was fixed last night and a trigger we had put in earlier
to log BK versions (so we know if we need to nag people to upgrade)
was broken.
--
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
