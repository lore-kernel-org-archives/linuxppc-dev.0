Date: Thu, 9 May 2002 23:52:58 -0400
From: Bill Fink <billfink@mindspring.com>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: 2.4.19-pre8-ben0 acenic driver and 867 MHz G4 sound problems
Message-Id: <20020509235258.50317d71.billfink@mindspring.com>
In-Reply-To: <20020509122340.72cf75bd.billfink@mindspring.com>
References: <20020509103702.528f1a7c.billfink@mindspring.com>
	<20020509130039.4964@smtp.wanadoo.fr>
	<20020509122340.72cf75bd.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 May 2002, Benjamin Herrenschmidt wrote:

> >First, thanks to BenH for his fix in the 2.4.19-pre8-ben0 kernel that
> >once again allows booting of the 867 MHz G4.  Unfortunately, I now have
> >a new problem as the acenic driver is now broken (using a NetGear GA620
> >NIC).  The previously working version was from a 2.4.17-pre2-ben0 kernel.
> >I can send a diff between the two sources if that would be of any help.
> >
> >Also, is there any update on why sound doesn't work on the 867?  It would
> >be nice to listen to CDs or watch DVDs on these machines.
>
> Yes, send the diff please, and CC the driver maintainer.

As you probably have seen by now, Anton Blanchard sent a patch which
fixes the problem.

> For sound, what makes you think is doesn't work ? (it should actually).

Oh, no beep when hitting delete at the tcsh prompt or when doing
an "echo ^G".

> Did you try tweaking the volume with a mixer like gmix or so ?

Yup, I tried that.

All that was earlier.  Based on your comment that it should actually
work, I gave it another go.  It turns out that I was using too simple
a test.  I made a bad assumption that since neither the delete test
or "echo ^G" produced a beep that the sound wasn't working.  It turns
out that if I had just tried out the app I was actually interested in
such as xine, I would have discovered that the sound was in fact working
fine.

This was using KDE with the artsd disabled.  I'm not really that familiar
with KDE.  I'm just setting up these 867 MHz G4s for some colleagues at
work and thought KDE would be a decent environment for them to use.  When
I switched to my normal environment of straight X and twm, then the delete
test and "echo ^G" produced beeps as expected.  So there's something about
KDE that keeps it from producing beeps, but the normal audio apps actually
do work OK.

The lesson I learned is not to stop after a single test failure, but to
also check if other independent tests can confirm the initial results.
And I'm just happy to have working sound on these machines at last.

						-Thanks

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
