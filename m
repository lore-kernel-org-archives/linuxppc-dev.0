Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC981B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 May 2011 22:03:45 +1000 (EST)
Date: Mon, 16 May 2011 14:03:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	callfiltering
Message-ID: <20110516120302.GB7128@elte.hu>
References: <1305299880.2076.31.camel@localhost.localdomain>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"H. PeterAnvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, agl@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* David Laight <David.Laight@ACULAB.COM> wrote:

> [...] unfortunately it worked by looking at the user-space buffers on system 
> call entry - and a multithreaded program can easily arrange to update them 
> after the initial check! [...]

Such problems of reliability/persistency of security checks is exactly one of 
my arguments why this should not be limited to the syscall boundary, if you 
read the example i have provided in this discussion.

Thanks,

	Ingo
