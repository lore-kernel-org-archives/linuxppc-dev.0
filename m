Date: Fri, 12 Sep 2003 09:17:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: Dan Malek <dan@embeddededge.com>,
	"Curtis, Allen (by way of Allen Curtis <acurtis@onz.com>)" <acurtis@onz.com>,
	PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8266ADS patch
Message-ID: <20030912161718.GH13672@ip68-0-152-218.tc.ph.cox.net>
References: <FA06AA2C99BCD511951200005A99441003BE170D@IRVEXCH1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FA06AA2C99BCD511951200005A99441003BE170D@IRVEXCH1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 12, 2003 at 08:59:51AM -0700, Curtis, Allen wrote:
> > > Here is a patch to make MPC8266ADS its own platform. Instead of creating
> a
> > > new platforms/ads8266.h header, ....
> >
> > Will the "other issues to be addressed" cause the need for more
> definitions
> > or further #ifdefs in the existing file?  If so, let's just go ahead and
> > create the new file now and just add to it later.
>
> And, better yet, why not just pull all of the ADS8266 bits in _devel now
> out to 2.4 proper?  (And, pretty please, for 2.6 as well? :))
>
> I'll do that if someone will review and commit the changes.

It's a deal.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
