From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>,
        <greyham@research.canon.com.au>
Subject: Re: Getting patches in (was: Re: Roles for distributions)
Date: Tue, 12 Sep 2000 10:59:18 +0200
Message-Id: <20000912085918.23901@192.168.1.10>
In-Reply-To: <200009120614.IAA00922@piglet.grunz.lu>
References: <200009120614.IAA00922@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I agree that this seems to be a major problem of the PPC Linux port at
>this time. It is not clear at all how the flow of patches from user
>contribution, to PPC kernel tree, to Linus' tree is happening... and
>unfortunately, too often, it just isn't happening.
>
>I've sent lots of patches to those people I thought were 'platfor
>maintainers', only to notice weeks or months later, that a few kernel
>releases later they were not in there. Patches just disappeared into the
>void, no reaction at all. _That_ is frustrating. If patches are refused
>for some reason, then fine, I've not done my homework, let me try again.
>But without any reaction, I haven't even gotten that chance.

That problem is not specific to the PPC port, how many times patches are
sent to Linus without an answer, but without anything happening neither.

The fact is that there are about 4 or 5 people from this list who can
feed things in the main PPC tree (Paul, Cort, Geert, Dan, me, I may be
missing others) and Linus/Alan usally get patches from Paul or Cort. Now
that Cort is "away", we rely mostly on Paul to push patches to Linus.

The latest batch of PPC patches sent by Paul, AFAIK, didn't appear in
Linus test8 (was it rejected ? I don't know)

That's one of the reasons why we have this sourceforge site now. Pleast
post your patches there. They may or may not get merged, but at least
they will be available in a central position and won't be forgotten.

>At the moment, BenH is actively tracking the patches on sourceforge. I
>do jope others will follow his example, and I also hope that more people
>will use sourceforge. Try it out, it's really esay ;-)

Well, a bit less actively for now, I want things to stabilize a bit and
get merged with Linus before feeding the tree with new patches (and I
have my own patches waiting too). Don't worry if you don't see anything
happening on the sourceforge site for the upcoming days, that doesn't
mean it's dead.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
