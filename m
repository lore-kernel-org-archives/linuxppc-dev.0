Date: Tue, 6 Apr 2004 13:01:58 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040406120158.GA7444@palantir8>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040405231321.GA1293@palantir8> <20040406073741.GA4008@fpirisp.portsdebalears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040406073741.GA4008@fpirisp.portsdebalears.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 06, 2004 at 09:37:41AM +0200, Kiko Piris wrote:
> It seems I do:
>
> ---8<---
> 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
>                      PowerMac Snapper (Dev 24) Sub-frame 0
> --->8---

Good, same chip I have.

> > This capture_source thing was added pretty recently.
>
> I don't quite understand you, sorry.

Well, the code is so new that the bug fixes have not made it into the
kernel yet. But they are in the alsa cvs node.
What I did is pick up revision 1.29 (the latest) from
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/ppc/tumbler.c

Make a backup of your existing tumbler.c file, just in case... Put the
new one in an recompile.

Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
