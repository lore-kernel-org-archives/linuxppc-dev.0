Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AFE9BB7CEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 06:56:32 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ppc64 sys_ipc breakage in 2.6.34-rc2
References: <20100322064759.GE24064@kryten> <m2ocigkzij.fsf@igel.home>
	<alpine.LFD.2.00.1003221102050.18017@i5.linux-foundation.org>
Date: Mon, 22 Mar 2010 20:56:22 +0100
In-Reply-To: <alpine.LFD.2.00.1003221102050.18017@i5.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 22 Mar 2010 11:07:14 -0700 (PDT)")
Message-ID: <m2k4t4ku55.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Hirokazu Takata <takata@linux-m32r.org>, James Morris <jmorris@namei.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	Jeff Dike <jdike@addtoit.com>, Anton Blanchard <anton@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>, "Luck,
	Tony" <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
	Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 22 Mar 2010, Andreas Schwab wrote:
>> 
>> ipc/syscall.c:17: error: conflicting types for ‘sys_ipc’
>> include/linux/syscalls.h:691: note: previous declaration of ‘sys_ipc’ was here
>
> Hmm. Right you are. Why don't I see this? (I already applied the patch)
>
> Ahh. Because this only triggers with __ARCH_WANT_SYS_IPC. But why didn't 
> Anton see it then? 
>
> Anyway, I assume the following fixes it. Can you verify?

Yes, this works.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
