Date: Wed, 17 Sep 2003 08:15:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
Cc: Scott Anderson <scott_anderson@mvista.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: boot udelay asm fix
Message-ID: <20030917151519.GC14509@ip68-0-152-218.tc.ph.cox.net>
References: <200309161854.h8GIseaF011976@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309161854.h8GIseaF011976@sullivan.realtime.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 16, 2003 at 01:54:40PM -0500, Milton Miller wrote:

> Hi Tom, Scott
>
> A feature of the assembler is to not check our instruction selection.
> Looks like this one gets the rounding wrong without the fix.  Patch
> against marcello 2.4 head, but is needed on all trees.

Fixed in the trees that Linus and Marcelo pull from.  *sigh*.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
