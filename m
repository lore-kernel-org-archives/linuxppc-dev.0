To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sleep: trackpad settings, screen blanking
References: <873d39n32k.fsf@dedasys.com>
	<20011121145821.2126@mailhost.mipsys.com>
From: davidw@dedasys.com (David N. Welton)
Date: 21 Nov 2001 16:16:30 +0100
Message-ID: <87n11g888h.fsf@dedasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

[ please CC replies to me ]

> >I have a first generation tibook, running Linux 2.4.14, and I have
> >a few itches that need scratching:

> >1) The screen doesn't always get blanked when it gets put to sleep.
> >   Known problem?  Fix being worked on?  If yes, I'd still be curious
> >   to hear what the problem was, as I had a cursory look at the code,
> >   but didn't have time to do any rebooting/hacking.

> Which kernel ? My rsync ? bk _2_4 ? _2_4_devel ? Linus ?

It's the "stable" kernel from the ftp site.

> >2) Trackpad settings aren't restored (or saved beforehand?) after
> >   sleep.  Same questions apply.

> That's normal for now.

I see... is anyone working on it? "KOBAYASHI R. Taizo" sent me a patch
that he says does it...  I suppose I don't have the time in any case
(nor much knowledge).

Thanks,
--
David N. Welton
   Consulting: http://www.dedasys.com/
Free Software: http://people.debian.org/~davidw/
   Apache Tcl: http://tcl.apache.org/
     Personal: http://www.efn.org/~davidw/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
