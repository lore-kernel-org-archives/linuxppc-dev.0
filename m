Date: Mon, 1 Jul 2002 06:55:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Fix pcore build in latest linuxppc_2_4_devel
Message-ID: <20020701135500.GB20920@opus.bloom.county>
References: <20020628123555.F3851@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020628123555.F3851@host110.fsmlabs.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 28, 2002 at 12:35:55PM -0600, Cort Dougan wrote:

> If anyone wants the BK patch, drop me a note.

I've commited this slightly modified.  Since i8259_{poll,irq} takes a
pt_regs *regs argument, we can call it directly from ppc_md.get_irq()
now.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
