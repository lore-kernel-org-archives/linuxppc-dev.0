Date: Fri, 14 Nov 2003 08:20:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Wolfgang Denk <wd@denx.de>, Dale Farnsworth <dale@farnsworth.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Gabriel Paubert <paubert@iram.es>
Subject: Re: MPC5200 Patches
Message-ID: <20031114152049.GB13003@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.GSO.4.21.0311122039580.1561-100000@waterleaf.sonytel.be> <55821B76-1669-11D8-A264-000393DBC2E8@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55821B76-1669-11D8-A264-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 14, 2003 at 12:11:06AM -0600, Kumar Gala wrote:

> What about a single i2c-mpc.c that handles 10x/824x/85xx/5xxx since
> they all seem to support the same programming model from what I can
> tell (5xxx seems not to support broadcast).  This would cover all
> non-CPM instances of I2C on Motorola PPC parts.

So long as it can be done in a clean manner, this is probably a great
idea.  Thanks for volunteering. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
