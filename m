Date: Tue, 6 Apr 2004 23:18:48 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040406221848.GA1641@palantir8>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040405231321.GA1293@palantir8> <20040406073741.GA4008@fpirisp.portsdebalears.com> <20040406120158.GA7444@palantir8> <20040406124325.GA17046@fpirisp.portsdebalears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040406124325.GA17046@fpirisp.portsdebalears.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I'm out of clues then. Must be something else affecting
this. I'm still on 2.6.3-benh and by the looks of it I'll stay on
that for a while and get some other work done.

Probably not relevant, but does the input source in alsa mixer work
okay for you?

Martin

On Tue, Apr 06, 2004 at 02:43:25PM +0200, Kiko Piris wrote:
>
> On 06/04/2004 at 13:01, Martin Habets wrote:
>
> > Well, the code is so new that the bug fixes have not made it into the
> > kernel yet. But they are in the alsa cvs node.
> > What I did is pick up revision 1.29 (the latest) from
> > http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/ppc/tumbler.c
> >
> > Make a backup of your existing tumbler.c file, just in case... Put the
> > new one in an recompile.
>
> Revision 1.29 of that file, AFAICS is the latest one.
>
> This is exactly the same file that comes with 2.6.5.
>
> If I understood you correctly...
>
> Thanks for replying, btw :-)
>
> --
> Kiko

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
