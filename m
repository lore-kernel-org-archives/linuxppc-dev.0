Message-ID: <3D10F388.5@embeddededge.com>
Date: Wed, 19 Jun 2002 17:11:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county> <3D10A0AC.409EF92B@imc-berlin.de> <20020619152528.GB12762@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> On Wed, Jun 19, 2002 at 05:18:04PM +0200, Steven Scholz wrote:
>

>>Hmm. Don't know. Maybe. But these are just DEFINES! So what should that
>>be bad?
>
>
> Oh yeah, right..  Hmm, it probably won't break anything then..

But, that's not the point.

The 2.4 source base is no longer supposed to be a development base.
The code works fine as it is, moving a bunch of #defines around because
some people like it that way isn't giving us any feature enhancement and
opens the door for making mistakes.  I personally like the file the way
it is because it is the logical collection of all communication processor
related information regardless of the board.  I'm sorry others don't
like it that way.

I don't know how many people have lived through previous transitions of
Linux kernel development to stable trees, but at some point you just have
to move to the development tree and let the "stable" tree become stable.
Instead of complaining about the development tree being unstable, you should
be investing some resources to make it better.  Why are you waiting for
someone else to do that so you can reap the benefits later?  The only
thing that should be happening in the 2.4 tree is bug fixing.  The 2.4
kernel is what it is, like it or not.  If you want something new and different,
it belongs in the 2.5 tree to show up at some point in the future.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
