Date: Mon, 8 Jan 2001 09:14:45 -0800
From: Larry McVoy <lm@bitmover.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tom Rini <trini@kernel.crashing.org>, Iain Sandoe <iain@sandoe.co.uk>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
Message-ID: <20010108091445.C3077@work.bitmover.com>
References: <20010108093204.I19404@opus.bloom.county> <Pine.LNX.4.05.10101081753120.30839-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10101081753120.30839-100000@callisto.of.borg>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 08, 2001 at 05:54:00PM +0100, Geert Uytterhoeven wrote:
> It may help to create nightly diffs between Linus' 2.4.0 and linuxppc_2_4 and
> put them on some FTP site.

bk help export

you want

bk export -tpatch

Cort's been using it for a year or more to send Linus patches.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
