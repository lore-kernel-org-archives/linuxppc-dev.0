Date: Wed, 20 Mar 2002 10:25:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020320172537.GH3762@opus.bloom.county>
References: <0203201704.AA10152@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203201704.AA10152@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 20, 2002 at 09:04:35AM -0800, Michael Sokolov wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Sure there is, for it to be accepted.
>
> Wait a minute, why am I even talking to you?

Because you enjoy our conversations? :)

> Mark said he is the responsible
> maintainer and promised to push my patch in a few days if there is no
> consensus by then, and I think I'll just wait a few days and then ask
> him to stick to his word.

And then you'll have to go and improve the patch anyhow, if you're going
to stick to your word. :)

> (I'm willing to bet $50 that in the next few days there will be no
> consensus nor will anyone else offer a counterpatch.)
>
> > And would you please make it
> > versus the _galileo tree
>
> Sorry, no, that would be a step backward and we need to move forward.

How is that a step backward?  All of the current galileo work is in that
tree.  And a quick diff of the enet drivers in the two trees shows a
good deal of differences, many of which aren't just cosmetic.  Isn't it
more 'natural' to update the most up to date file?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
