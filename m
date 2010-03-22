Return-Path: <anton@ozlabs.org>
Date: Tue, 23 Mar 2010 09:01:38 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ppc64 sys_ipc breakage in 2.6.34-rc2
Message-ID: <20100322220138.GF24064@kryten>
References: <20100322064759.GE24064@kryten> <m2ocigkzij.fsf@igel.home>
	<alpine.LFD.2.00.1003221102050.18017@i5.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LFD.2.00.1003221102050.18017@i5.linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Hirokazu Takata <takata@linux-m32r.org>, James Morris <jmorris@namei.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, "Luck,
	Tony" <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
	Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > ipc/syscall.c:17: error: conflicting types for ‘sys_ipc’
> > include/linux/syscalls.h:691: note: previous declaration of ‘sys_ipc’ was here
> 
> Hmm. Right you are. Why don't I see this? (I already applied the patch)
> 
> Ahh. Because this only triggers with __ARCH_WANT_SYS_IPC. But why didn't 
> Anton see it then? 
> 
> Anyway, I assume the following fixes it. Can you verify?

Sorry, I forgot to quilt add. Stupid screw up, thanks Andreas for catching
it so quickly.

Anton
