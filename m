Date: Tue, 30 Oct 2001 16:21:57 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: David Boutcher <boutcher@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
Message-ID: <20011030162157.G13806@altus.drgw.net>
References: <OF89A2837B.F5221EF4-ON86256AF5.00703EC4@rchland.ibm.com> <20011030133238.F13925@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011030133238.F13925@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Tue, Oct 30, 2001 at 01:32:38PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 30, 2001 at 01:32:38PM -0700, Tom Rini wrote:
>
> On Tue, Oct 30, 2001 at 02:28:40PM -0600, David Boutcher wrote:
> > > It's pre5 ? I think Tom's fix is wrong. It should probably be
> > > copy_user_page or copy_cow_page (I use the last one). Without that,
> > > the cache avoidance will probably win a direct ticket to hell ;)
> >
> > Changing the fix to copy_cow_page fixed the problem...so I pushed that
> > change into the devel tree.  Hopefully Tom doesn't mind.
>
> Not at all.  I just heard Paul say copy_highpage was gone in _devel and
> something about copy_mem_page. :)  I need to go and get my breakable
> PPCs up and running again....

Let's see.. I think that's three changesets that made a change to memory.c
today ;)

Benh pushed one with 'copy_user_page' instead, but it looks like David's
version won the merge.. So is the copy_cow_page optimization usefull in
this case, or not?

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
