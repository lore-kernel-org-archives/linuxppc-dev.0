Message-ID: <FA06AA2C99BCD511951200005A99441003BE170D@IRVEXCH1>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>
Cc: "Curtis, Allen (by way of Allen Curtis <acurtis@onz.com>)" <acurtis@onz.com>,
	PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 12 Sep 2003 08:59:51 -0700
Subject: RE: MPC8266ADS patch
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Here is a patch to make MPC8266ADS its own platform. Instead of creating
a
> > new platforms/ads8266.h header, ....
>
> Will the "other issues to be addressed" cause the need for more
definitions
> or further #ifdefs in the existing file?  If so, let's just go ahead and
> create the new file now and just add to it later.

And, better yet, why not just pull all of the ADS8266 bits in _devel now
out to 2.4 proper?  (And, pretty please, for 2.6 as well? :))

I'll do that if someone will review and commit the changes.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
