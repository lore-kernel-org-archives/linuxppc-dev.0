Message-ID: <3C850D8D.2FD942E6@etx.ericsson.se>
Date: Tue, 05 Mar 2002 19:25:17 +0100
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: Jim Duey <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut networking problems
References: <3C837EED000002AE@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had to make a static arp entry in the server to make it work but that was
the prom code not linux that was the problem.

Jim Duey wrote:
>
> I have a Walnut board that I've been working with for sometime.  I got it
> working fine with Linux, but the networking seems to be fragile.  For
> instance, I switch from a Ethernet switch to a hub and now the board won't
> boot over the network.  Also, it has never been able to use DHCP.  What are
> teh reasons for this fragility?  If I design the 405GP into my product, will
> it have the same problems or is this strictly a Walnut related issue?
>
> Jim
>

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
