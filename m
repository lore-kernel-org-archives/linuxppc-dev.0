Message-ID: <3CFEE9A3.5060300@embeddededge.com>
Date: Thu, 06 Jun 2002 00:48:35 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax>	<3CFC0D3F.9030901@embeddededge.com>	<20020604035947.GH2762@zax>	<3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> Dan, you continue to surprise me.

Eh?

> .....  You complain about a kB or two for
> a device tree

When did I ever complain about a device tree?  I think it's the right
idea, I just didn't like the way we were getting there on systems
that don't have OF.

> .... but happily throw away anything from 16kB to 128kB or
> more just to simplify iopa, which should not be needed anyway.

What isn't needed?  The page tables or the iopa()?  I'm tired of having
different methods to look up VM information just because the memory
was allocated in a different way.  With iopa() (which seems fine for
other architectures to use) I don't care how the memory was allocated,
I just feed it a virtual address and get the answer.  What's wrong with
that (other than it's not a hack :-)?  The page tables have always
been there, and it's not a big deal.  Why haven't we done the same
hack for processors with BATs?  They don't need the page tables either.

I also stated the importance of the page tables is to allow background
hardware debuggers to look up translations so they can work with Linux.
Kind of a nice thing to have once in a while.

I find a simple solution for an enhancement and you don't like it because
it isn't a big hacked up mess (or maybe because I had an original thought).
If I would have made the same hacked up mess you have done it wouldn't have
been checked in.....not long ago all of the embedded stuff was viewed as a
problem child, and today it's OK to hack up generic code with an #ifdef
for a specific IBM embedded processor????  Does that surprise you? :-)

I haven't changed my point of view on any of the embedded Linux because
that is pretty much all I have ever done.  It's the rest of you that can't
determine on which side of the fence you want to play.  Stop picking on me
or I'll take all of my toys to a different playground :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
