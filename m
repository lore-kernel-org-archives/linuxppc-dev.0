Date: Mon, 6 Aug 2001 13:26:00 -0500
From: Michael Scott Shappe <mshappe@nxnetworks.com>
To: Dan Malek <dan@mvista.com>
Cc: Elan Feingold <elan@nxnetworks.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel hangs at my_console_write
Message-ID: <20010806132600.A20948@nxnetworks.com>
References: <NDBBLJLFCLLGDHJPGKGCKEBPEDAA.elan@nxnetworks.com> <3B6EDD68.55E51A8A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B6EDD68.55E51A8A@mvista.com>; from dan@mvista.com on Mon, Aug 06, 2001 at 02:09:44PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> If you take everything from the same kernel baseline, all of this will
> match.  At one point late in the 2.3.xx development, the values
> were changed from MHz to Hz.  People weren't patching/merging
> correctly to get all of the right parts at the same time.

Dan --

I can accept this statement -- it certainly makes sense -- however, it doesn't
quite fit what we actually did. We took a stock linux 2.4.5, applied a patch
that was named 'linuxppc2.4_vs_v.2.4.5.patch' (because there wasn't a 2.4.6),
which we found by chasing links from <http://www.linuxppc.org/>, and went from
there (I'd give you the exact URL, but linuxppc.org isn't answering, right
now). On the surface, this seems like it should have been the Right Thing.

I'm willing to accept that it wasn't, however, especially if someone can tell
us what the Right Thing is :-D When I tried to build an entirely unmodified
v.2.4.6 kernel, for example, it didn't even build (symbols had changed names
and only about half the code had the names changed).

Mike Shappe
NxNetworks, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
