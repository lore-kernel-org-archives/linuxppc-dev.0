Date: Wed, 17 Sep 2003 12:30:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Guertin <mguertin@macdiscussion.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: rsync file permissions
Message-ID: <20030917193055.GD14509@ip68-0-152-218.tc.ph.cox.net>
References: <3425C332-E872-11D7-AF0B-000A958557FC@macdiscussion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3425C332-E872-11D7-AF0B-000A958557FC@macdiscussion.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 16, 2003 at 02:18:42PM -0400, Mark Guertin wrote:

>
> Hey All
>
> I noticed that again the rsync module for linuxppc-2.2 has a couple
> file permission problems from source.mvista.com.  Tom fixed this a
> little while back, but it's popped up again ... maybe in pushing from
> bk -> rsync ?  This problem seems to have only come back on the latest
> update.

Actually, I didn't touch 2.2 since I didn't know it was broken (source
was a slower machine back then, so fixing all repos would have taken
hours).  I'm starting a rebuild right now of:
linuxppc_2_4 linuxppc_2_4_devel linuxppc-2.5 linuxppc_2_4_benh
linuxppc-2.4 linuxppc_2_2
and it should be done shortly.  While I'm thinking of it, does anyone
know of other trees I should be mirroring ?  Ben?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
