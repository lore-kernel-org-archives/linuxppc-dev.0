Date: Mon, 25 Mar 2002 15:05:40 -0700
From: Val Henson <val@nmt.edu>
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020325150540.B23479@boardwalk>
References: <val@nmt.edu> <16802.1017017050@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16802.1017017050@msa.cmst.csiro.au>; from Murray.Jensen@cmst.csiro.au on Mon, Mar 25, 2002 at 11:44:10AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 25, 2002 at 11:44:10AM +1100, Murray Jensen wrote:
>
> On Sun, 24 Mar 2002 12:09:30 -0700, Val Henson <val@nmt.edu> writes:
> >How about one BI_IGNORE type, and driver writers and firmware authors
> >can put whatever they feel like inside that bi_rec?
>
> The kernel should simply ignore any bi_rec it doesn't know about. You don't
> need a special record tag for this. Any bi_recs within bi_recs are all ignored
> in one fell swoop, since the outer record tag is unknown.

I know most of you understand this, but I just wanted to make it
clear:

The kernel should simply ignore any bi_rec it doesn't know about - and
does.  The question is, how can we guarantee that the kernel doesn't
know about that bi_rec?  The answer is that we need to reserve at
least one (or several, under Ben's plan) bi_rec types that are
guaranteed not to be used by the kernel.  That's all I was trying to
say.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
