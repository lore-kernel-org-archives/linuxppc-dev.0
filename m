Date: Mon, 26 Jul 2004 16:07:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Olaf Hering <olh@suse.de>,
	Stef Simoens <stefaan.simoens@coditel.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040726230734.GH28588@smtp.west.cox.net>
References: <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <40E75DC7.7070601@coditel.net> <20040704024149.GB2146@smtp.west.cox.net> <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be> <E2EB9906-CDD7-11D8-92C8-000A95A0560C@us.ibm.com> <20040725060754.GE7099@bubble.modra.org> <20040726193652.GE28588@smtp.west.cox.net> <20040726230353.GX7099@bubble.modra.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040726230353.GX7099@bubble.modra.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 27, 2004 at 08:33:53AM +0930, Alan Modra wrote:

> On Mon, Jul 26, 2004 at 12:36:52PM -0700, Tom Rini wrote:
> [about ppc .machine]
> > But working in what versions of binutils ?
>
> HJ's 2.14.90.0.8 and later, FSF 2.15 release.

OK.  I suppose when we force 2.15 as a miniumum we need to remember to
revist using this then.  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
