Date: Wed, 9 Aug 2000 11:54:03 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000809152541.9611@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000809115042.866F-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Benjamin Herrenschmidt wrote:

> Ok. Then for this to work, we need to slightly change the boot code not
> to call simply ppc_md.get_rtc_time(), but to also adjust it on pmac using
> the pram timezone. That means adding a new ppc_md.fixup_time() used only
> at boot, or adding a "fixup" parameter to ppc_mc.get_rtc_time() set to 0
> in normal cases and to 1 on first call during boot.

Or let ppc_md.time_init() return offset between ppc_md.get_rtc_time()
value and UTC and use the offset in time_init() as I proposed
previously...


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
