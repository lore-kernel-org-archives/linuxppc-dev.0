Date: Thu, 8 Jul 2004 18:43:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>, Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040709014300.GO23135@smtp.west.cox.net>
References: <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de> <20040705183219.GI2146@smtp.west.cox.net> <20040709013429.GN23135@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040709013429.GN23135@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 08, 2004 at 06:34:29PM -0700, Tom Rini wrote:
[snip]
> OK.  After giving this a whirl (after a NAK from Matt, privately), it looks
> like some versions of binutils don't make proper use of -many (in 2.14 it
> will override ppc_cpu, and PPC_OPCODE_ANY doesn't look to be used).  So
> that brings us to the following patch.  Olaf, can you please verify this
> still works for you?  Paul, is this OK with you?

The other alternative, if we want to try and rely on -many working w/o
other flags passed is to depend on binutils-2.15* or newer.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
