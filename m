Message-ID: <39BE1A6B.8798C598@charter.net>
Date: Tue, 12 Sep 2000 06:58:35 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Manav Mediratta <manav@astra.ee.iitm.ernet.in>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: RS232-ports on MPC850 FADS. Can they talk?]
References: <39BDAC72.25B84092@astra.ee.iitm.ernet.in>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Manav Mediratta wrote:
> Hello there,
> I'm working with the MPC850 fads. I need to check if the RS232 port works.
> So I connected it to hyperterm and ran the RS232 check(T6 using MPCbug).
> Its supposed to be a loopback test but I ran it in open loop just to see
> if something comes up. But I'm gettin' nothing.
>
> Does anybody know why this happens?

Nope, I do not.
I have a FADS850SAR that has been working quite nicely for
half a year or so.  No problems that I can tell, and I get
output (and can input) on RS232 port 1 just fine.
I'm not sure what T6 does though - but I also use mpcbug.
I'm just about finished adding support for this board to
ppcboot; if that is something you would be interested in,
then please just hang on a bit more.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
