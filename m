Date: Thu, 1 Apr 2004 12:11:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Sylvain Munaut <tnt@246tNt.com>
Subject: Re: Proposed Kconfig update patch for help text)
Message-ID: <20040401191131.GG26876@smtp.west.cox.net>
References: <20040401171956.GD26876@smtp.west.cox.net> <20040401185656.871ECC10A4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040401185656.871ECC10A4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 08:56:51PM +0200, Wolfgang Denk wrote:
> In message <20040401171956.GD26876@smtp.west.cox.net> you wrote:
> >
> > > So far, it's all we have, right? Or do you have anything significant-
> > > ly better?
> >
> > As I said, someone is working on the second option I described, but I
> > don't know how far they have gotten.
>
> Is this a secret or what? Why don't you give names?  Why  doesn't  he
> show up on this list?

Because I'm not omniscient?  Looking back in the linuxppc-embedded
archives, and recalling his nickname from IRC, it appears to be Sylvain
Munaut <tnt@246tNt.com>, whom you've even answered 5200 questions for.
Sylvain, have you made much progress on 52xx support in 2.6?

> > 2.6 support, without the Motorola code.  If there's a specific person at
> > Motorola who'd be interested in what the Linux community has to say
> > about the DMA code, no one has told me who.
>
> You are not working on this, or are you?

<hat="MontaVista Employee">I personally am not, but I know engineers
who are or have in the recent past, worked on 5xxx && Linux in MV</hat>
<hat="Community Person">Since I do try and get changes people make into
kernel.org, Yes</hat>

> > > Also, isn't this kind of wasted effort as the target is still moving?
> >
> > What target?  The Motorola code?  The 5xxx hw line?  If you're talking
>
> The Motorola code, and to some extend the hardware.

As I've stated before, in reference to other vendor-provided HAL code,
if the vendor is willing to work to address community concerns about the
vendor code (which includes subscribing to linuxppc-dev and -embedded so
they can field questions / comments / concerns about it), that works for
me.  But I had been under the impression that Motorola did not
particularly care to fix the concerns that had been raised.  If this
impression is incorrect, then I'd like to see someone step up, who has
authority to address said concerns (such as to paraphrase Dan Malek, why
do we need this?).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
