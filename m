Subject: Re: New 745x errata
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20031114162414.GD13003@ip68-0-152-218.tc.ph.cox.net>
References: <1068721518.23764.84.camel@newt>
	<20031114162414.GD13003@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Date: 17 Nov 2003 14:57:53 +0000
Message-Id: <1069081074.10537.16.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-11-14 at 16:24, Tom Rini wrote:
> On Thu, Nov 13, 2003 at 11:05:17AM +0000, Adrian Cox wrote:
> > 1) The BTIC doesn't work reliably: it can cause execution of corrupted
> > instructions. (This is listed in the errata for the 7450 and 7457, but
> > not for the 7455. I'll only believe that the 7455 escaped this bug if I
> > hear confirmation out of Motorola.)
>
> I've done the opposite in something I've been waiting for 2.4.24-pre to
> come out to fix.  But I agree that it is odd that it's not listed on the
> 7455.

Still no word back from Motorola on the 7455. I think your patch should
go in.

Any opinion on the dcbt issue?  It looks like it could provide a way for
a malicious userspace application to crash the machine, though it needs
a combination of:
1) good timing
2) a peripheral that would be confused by an extra read cycle

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
