Date: Tue, 6 Apr 2004 14:43:25 +0200
From: Kiko Piris <linuxppc@pirispons.net>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040406124325.GA17046@fpirisp.portsdebalears.com>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040405231321.GA1293@palantir8> <20040406073741.GA4008@fpirisp.portsdebalears.com> <20040406120158.GA7444@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040406120158.GA7444@palantir8>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 06/04/2004 at 13:01, Martin Habets wrote:

> Well, the code is so new that the bug fixes have not made it into the
> kernel yet. But they are in the alsa cvs node.
> What I did is pick up revision 1.29 (the latest) from
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/ppc/tumbler.c
>
> Make a backup of your existing tumbler.c file, just in case... Put the
> new one in an recompile.

Revision 1.29 of that file, AFAICS is the latest one.

This is exactly the same file that comes with 2.6.5.

If I understood you correctly...

Thanks for replying, btw :-)

--
Kiko

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
