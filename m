Date: Mon, 17 Sep 2001 16:22:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Barada <pbarada@mail.wm.sps.mot.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: walnut configuration
Message-ID: <20010917162204.J14279@cpe-24-221-152-185.az.sprintbbd.net>
References: <200109172115.f8HLFCc20783@hyper.wm.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200109172115.f8HLFCc20783@hyper.wm.sps.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 17, 2001 at 05:15:12PM -0400, Peter Barada wrote:

> Has *anyone* gotten the linuxppc_2_4_devel tree to build for a walnut board?
> If so, what did you have to do... I've tried the following:
>
> I've gotten a BK resync of the linuxppc_2_4_devel tree as of today and
> attempted to:

Are you using BK or the rsync version of the bk trees?  If you're using the
rsync version, are you using --delete?  or -u ? -u is bad, --delete is good.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
