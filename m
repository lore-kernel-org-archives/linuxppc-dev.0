Date: Tue, 14 Jan 2003 08:50:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Der Herr Hofrat <der.herr@mail.hofr.at>
Cc: Khai Trinh <kqtrinh@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where is lilo.conf in the kernel source tree?
Message-ID: <20030114155021.GA791@opus.bloom.county>
References: <20030110191126.74442.qmail@web11508.mail.yahoo.com> <200301102033.h0AKXr114249@hofr.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301102033.h0AKXr114249@hofr.at>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jan 10, 2003 at 09:33:53PM +0100, Der Herr Hofrat wrote:
>
> >
> > I would like to reserve a piece of High RAM memory for
> > DMA. The Linux 2.4 Drivers book show to appand
> > MEM=reserve_size to the lilo.conf file.
> >
> > Would someone please let me know where this file is in
> > the kernel tree? I couldn't seem to locate it.
>
> its in /etc/ by default not in the kernel tree.

... and more importantly lilo is only one of many boot methods which is
ia32 (afaik) only.  Argument passing is per-arch.  On PPC32, you can set
CONFIG_CMDLINE_BOOL=y and then set a cmdline to use.  If you're using
PPCBoot on your board, there's another way to do it, without recompiling
the kernel.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
