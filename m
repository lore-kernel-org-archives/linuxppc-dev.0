Date: Fri, 12 Sep 2003 08:50:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: "Curtis, Allen (by way of Allen Curtis <acurtis@onz.com>)" <Allen.Curtis@Thales-IFS.com>,
	PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8266ADS patch
Message-ID: <20030912155016.GG13672@ip68-0-152-218.tc.ph.cox.net>
References: <5.2.1.1.2.20030910174452.02767580@192.168.1.10> <3F5FEFA0.1080809@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F5FEFA0.1080809@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 10, 2003 at 11:44:32PM -0400, Dan Malek wrote:
>
> Curtis, Allen (by way of Allen Curtis ) wrote:
>
> > Here is a patch to make MPC8266ADS its own platform. Instead of creating a
> > new platforms/ads8266.h header, ....
>
> Will the "other issues to be addressed" cause the need for more definitions
> or further #ifdefs in the existing file?  If so, let's just go ahead and
> create the new file now and just add to it later.

And, better yet, why not just pull all of the ADS8266 bits in _devel now
out to 2.4 proper?  (And, pretty please, for 2.6 as well? :))

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
