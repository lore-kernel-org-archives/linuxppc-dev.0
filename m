Date: Wed, 10 Jan 2001 20:44:38 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Linux PPC Developer Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bk 2.4.1p1 (was status of 2.4.0. etc)
In-Reply-To: <20010110080532.A024BDBA68@atlas.valhalla.net>
Message-ID: <Pine.SOL.3.95.1010110203612.23049A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 Jan 2001, Iain Sandoe wrote:

> Well, not without a little struggle (and some great help from Larry) I have
> now got the bk 2_4_0 tree installed, pulled & built (vanilla).
>
> happy to say (g3/beige only so far, and not much functionality tested yet -
> an all-nighter) it seems OK.
>
> On Wed, Jan 10, 2001, Derek Homeier wrote:
> > On Tue, 9 Jan 2001, Iain Sandoe wrote:
> >> Which version of xmms?
> > 1.0.1
>
> Hmmm... I'm running 1.2.3 (hint ;-) so I can't help much there
> - but it just ran fine on a test file under 2.4.1p1.
>
O.K., I'll give 1.2.4 a try. If it helps, I could also build it with '-g',
but since it doesn't even seem to touch the dmasound modules, that's probably
not the point to step in.
However, I rsynced Paul's tree again last night (still reports as "2.4.0",
but there seemed to be quite a few changes), and sound now appears to be
much more stable (mpg123 doesn't halt, no other apps crashing so far).
xmms, fwiw, no reports an "Illegal instruction" instead of "Bus error" on
crashing =-/.

Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
