Subject: Re: boot udelay asm fix
From: Scott Anderson <scott_anderson@mvista.com>
To: Milton Miller <miltonm@bga.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200309161854.h8GIseaF011976@sullivan.realtime.net>
References: <200309161854.h8GIseaF011976@sullivan.realtime.net>
Content-Type: text/plain
Message-Id: <1063835202.3706.1.camel@dhcp236.mvista.com>
Mime-Version: 1.0
Date: 17 Sep 2003 14:46:43 -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-09-16 at 11:54, Milton Miller wrote:
> A feature of the assembler is to not check our instruction selection.
> Looks like this one gets the rounding wrong without the fix.  Patch
> against marcello 2.4 head, but is needed on all trees.
Thanks for the catch.  Next time, I swear I'm going to have
gcc generate the assembly for me no matter how simple it is...

Thanks again,
  Scott


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
