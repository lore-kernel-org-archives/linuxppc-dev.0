Date: Tue, 19 Dec 2000 15:33:43 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Lonnie L VanZandt <lonnie@timesys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Installing LinuxPPC 2000 on an MCP750
Message-ID: <20001219153343.G19150@hq.fsmlabs.com>
References: <FAEGKJHOHCILEABGDOJJIEPCCIAA.lonnie@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FAEGKJHOHCILEABGDOJJIEPCCIAA.lonnie@timesys.com>; from Lonnie L VanZandt on Tue, Dec 19, 2000 at 03:24:54PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} Ok, tired of having to reinstall Debian potato by ftp over a slow link, I
} fell for the marketing claims at Linuxppc.com about the wonderful CD that
} would boot and install on Motorola embedded PPC boards.
}
} Unfortunately, it appears that only a Mac machine can boot the CD directly.
} (Why would anyone buy such a mass produced, ugly thing anyway when one can
} have such a big hunking industrial looking chassis? I hate these Mac-centric
} guys, they're as bad as their Wintel-loving cousins.)
}
} Where do I get LinuxPPC installer images for a _real_ machine like my MCP750
} board? The "PReP" images at ftp.linuxppc.org looked promising, but the
} zImage hangs immediately after residual data loading...

I've had some luck with the yellowdog CD's and embedded systems.  The cd
includes a boot image for the SynergyMicro board and it should be easy to
adapt to another system.

The end result is a bit of roll-your-own is involved.  If you cross-compile
a kernel, boot it and tell it to use the CD-ROM as root you should be good
to go.  I know that the yellowdog CD works across a serial line (a truly
beautiful thing, in my eyes...).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
