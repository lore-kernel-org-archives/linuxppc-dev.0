Date: Wed, 21 Nov 2001 16:54:21 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "David N. Welton" <davidw@dedasys.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: sleep: trackpad settings, screen blanking
In-Reply-To: <87n11g888h.fsf@dedasys.com>
Message-ID: <Pine.LNX.4.33.0111211648200.21616-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > >2) Trackpad settings aren't restored (or saved beforehand?) after
> > >   sleep.  Same questions apply.
>
> > That's normal for now.
>
> I see... is anyone working on it? "KOBAYASHI R. Taizo" sent me a patch
> that he says does it...  I suppose I don't have the time in any case
> (nor much knowledge).

IIRC the problem was with asynchronous ADB resetup after sleep; pmud
doesn't wait for that to finish and restores settings that are
subsequently cleares by the bus resetup. BenH thought about ways to fix
this, nothing final yet (that's why it reads 'for now' above :-).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
