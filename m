Date: Wed, 12 Jul 2000 17:40:44 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <20000712114049.26089@mailhost.mipsys.com>
Message-ID: <Pine.SOL.3.95.1000712165903.22186B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Benjamin Herrenschmidt wrote:

> >Yes, Lombard 333 MHz standard configuration.
> >
> >I did compile dmasound as module (I noticed that after applyiing your patch,
> >dmasound was unselected in .config - is there a reason for this?).
> >I will test this, though I'm not sure if it's easy to reproduce -
> >if it takes a prolonged time of sleep for the effect to come up...
>
> Did you experience this problem at all with previous kernel ? I'm
> wondering if it would be good to leave the powerbook a bit more time when
> coming out of sleep before turning back on the various parts.
>
Nothing quite like this with anything before 2.2.17pre9, but slowing down
things a bit might certainly be good idea. As I mentioned, when I leave
it sleeping overnight, about the first thing that comes up is cron.daily
with all its updates, and I have noticed before that the powerbook is
quite sensitive in that stage, read: if I start right then to work
and put too much additional load it is quite prone to freezes.

						Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
