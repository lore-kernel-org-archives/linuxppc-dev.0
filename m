Message-ID: <3B79115A.AA9B5550@inn.ericsson.se>
Date: Tue, 14 Aug 2001 13:54:02 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: Gavin Hemphill <hemphill@drea.dnd.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC bk repos reorg
References: <15218.2656.8980.846399@cargo.ozlabs.ibm.com> <20010808211410.J7728@work.bitmover.com> <15218.4778.270562.782105@cargo.ozlabs.ibm.com> <20010808213806.C13789@work.bitmover.com> <15218.7077.297813.862317@cargo.ozlabs.ibm.com> <20010809192852.L13789@work.bitmover.com> <20010810080751.B31136@cpe-24-221-152-185.az.sprintbbd.net> <20010810081659.A13789@work.bitmover.com> <3B77D988.6A9D6C60@drea.dnd.ca> <20010813083553.B4702@work.bitmover.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I can't even use the old way from work but I have done some testing with bk
from home in aticipation of the 4xx updates that has been RSN the last few
month.

The revtool is a really nice tool to find out what has changed and once I
figured out that I needed to also do a get command everything that I need
works. BUT one thing I did not like is the fact that a grep -r now catch not
only the source but also the file in the repository directory. Is there a way
to work with bk that the source is not in the same place as the bk files?


Larry McVoy wrote:
>
> For now use the old port numbers those should still work while I go poke
> at this.
>
> On Mon, Aug 13, 2001 at 10:43:36AM -0300, Gavin Hemphill wrote:
> > Larry I just tried out the anonymous access using the new syntax and
> > found that (of course) it won't work through our firewall. I'd had a
> > hole punched in the firewall to allow pull's etc. but it's tied to
> > port numbers. Do you have any suggestions on how to handle this with
> > the reorganized parents.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
