Date: Wed, 21 Nov 2001 19:33:06 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: benh@kernel.crashing.org
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org,
	"David N. Welton" <davidw@dedasys.com>
Subject: Re: sleep: trackpad settings, screen blanking
In-Reply-To: <20011121182524.13700@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10111211929390.29172-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >IIRC the problem was with asynchronous ADB resetup after sleep; pmud
> >doesn't wait for that to finish and restores settings that are
> >subsequently cleares by the bus resetup. BenH thought about ways to fix
> >this, nothing final yet (that's why it reads 'for now' above :-).
>
> My current kernels will block ADB writes when the bus is still

I think that's what we discussed. How current a kernel do I need for that?

> beeing reset/probed. So pmud should work. However, I had some
> reports of pmud just screwing up the trackpad in this case, which
> may be related to a bug in an older release of pmud. One problem
> is that I think debian did some updates to it, but the maintainer

Yep; an off-by-one error in the reply buffer addressing.

> did't update the official version. Well, I might have just missed
> something here as I use to rely on debian's version :)

I think Stephan released an update for that after I alerted him to the
problem. But I've gotten too far out or sync with him again...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
