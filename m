Date: Thu, 10 May 2001 11:49:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linuxppc-embedded@lists.linuxppc.org, Murray.Jensen@cmst.csiro.au
Subject: Re: linuxppc_2_5 source tree (and others)
Message-ID: <20010510114909.B28206@opus.bloom.county>
References: <200105101840.f4AIe5d413262@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200105101840.f4AIe5d413262@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, May 10, 2001 at 02:40:05PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 10, 2001 at 02:40:05PM -0400, Albert D. Cahalan wrote:
>
> Tom Rini writes:
> > On Thu, May 10, 2001 at 06:38:02PM +1000, Murray Jensen wrote:
>
> >> Hi, I see that the linuxppc_2_5 bk tree has disappeared from fsmlabs, and
> >> has been replaced with a linuxppc_2_4_devel tree. Could someone in the
> >> know please post a quick update what this means, and perhaps what the
> >> future holds wrt 2.4/2.5 linuxppc (embedded)?
> >
> > I was hoping Cort would mention this here, but 2_5 has been 'dead' for a
> > while and is finally gone too.  There's still mirrors of it however.
> > It will exist again, but when 2.5.0 appears and will be based off the
> > linux_2_4 tree or so.  Right now 2_4_devel isn't up to date wrt 8xx/4xx, and
> > some new boards 2_5 had.  I'm working on it. :)
>
> Oh, lovely.
>
> I'm very glad to have ignored this BitKeeper nonsense for
> the most part then. I knew there was a good reason to rely
> on the one true source tree from Linus. I'm not screwed like
> all the people working from linuxppc_2_5 are.
>

Right.  But the "one true source tree from Linus" doesn't always work for
other arches.  Why?  Keeping stuff in 100% never works.  There almost always
has been a slightly more up-to-date tree than Linus' for ages (when did the
first -ac patch come out, anyone know?).  And, who exactly is screwed that's
working from the old 2_5 tree?  There hasn't been any new activity in it for
ages.  Shortly (mainly once I'm done w/ finals) it'll be little more than
exporting your local changes from '2_5' and applying them in 2_4_devel.  Yes,
history bits will be lost, but such is life. :)

> On the other hand, I had to do my own PowerCore 6750 VME port
> for the 2.4 kernel. That sucked. It would be nice if everyone
> had the decency to submit stuff to Linus in a way that he finds
> acceptable, rather than hoarding source code in obscure places
> that are only accessible via non-standard non-free software.

So use rsync and import into your own CVS tree.  I think it sucks too
that bk isn't gpl'ed, but hey.  I don't really care that much.  I'd wager
your port would have sucked much less if you were working off the 2_5 tree
too (mvme5100 support is currently 4 mvme-specific files, and some new
common ones other boards use too.  Some pcore boards are about as simple
too).

> So, how did _you_ know that 2_5 has been 'dead' for a while?

Well, it was on the linuxppc-commit list, which Cort has mentioned a few time
(hence it's majordomo now and not a sendmail alias like it used to be).
It's even mentioned on the page that talks about the bk trees:
http://www.fsmlabs.com/linuxppcbk.html

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
