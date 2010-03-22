Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E72E5B7CE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 07:14:46 +1100 (EST)
Date: Mon, 22 Mar 2010 21:01:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: ppc64 sys_ipc breakage in 2.6.34-rc2
Message-ID: <20100322200116.GA7955@lst.de>
References: <20100322064759.GE24064@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100322064759.GE24064@kryten>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Hirokazu Takata <takata@linux-m32r.org>, James Morris <jmorris@namei.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, "Luck,
	Tony" <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
	Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 22, 2010 at 05:47:59PM +1100, Anton Blanchard wrote:
> The patch below changes second from an int to an unsigned long which fixes
> shmget on ppc64 (and I assume s390, sparc64 and mips64).

Looks good, except that the prototype in the header also needs to be
adjusted.
