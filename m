Subject: Re: Trivial cleanup in ocp_uart.c
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: Armin Kuster <akuster@mvista.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Tom Rini <trini@kernel.crashing.org>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <15643.30156.351253.97783@argo.ozlabs.ibm.com>
References: <20020620073440.GC20689@zax>
	<20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax>
	<20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax>
	<3D1B81C3.6060907@mvista.com>
	<15643.30156.351253.97783@argo.ozlabs.ibm.com>
Content-Type: text/plain
Date: 27 Jun 2002 23:12:24 +0200
Message-Id: <1025212344.29117.109.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2002-06-27 at 22:30, Paul Mackerras wrote:
>
> Armin Kuster writes:
>
> > This is in devel, I guess what I should have done was fork and do all
> > the work there and then provide a complete solution to devel. :)
>
> No, working in devel is fine.  But it would help if you could write
> down your thoughts about where this is going, and where you would
> like it to end up, and post them to the list.

And I would very much like to get a clarification how stuff gets moved
from devel to 2.4. What is the criteria used here?? I got the impression
when it was started that it was intended as a testing area before moving
it into 2.4 but the moving it seems to be very slow.

Should perhaps a change that has been in devel for month without ending
up in 2.4 be moved to 2.5.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
