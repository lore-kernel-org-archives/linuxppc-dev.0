Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id 02AB9B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 May 2011 16:43:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Date: Sun, 15 May 2011 08:42:07 +0200
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<201105132135.34741.arnd@arndb.de>
	<BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
In-Reply-To: <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201105150842.07816.arnd@arndb.de>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	agl@chromium.org, linux-kernel@vger.kernel.org,
	Eric Paris <eparis@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 14 May 2011, Will Drewry wrote:
> Depending on integration, it could even be limited to ioctl commands
> that are appropriate to a known fd if the fd is opened prior to
> entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
> with a filter of "1" then narrowed through a later addition of
> something like "(fd == %u && (cmd == %u || cmd == %u))" or something
> along those lines.
> 
> Does that make sense?

Thanks for the explanation. This sounds like it's already doing all
we need.

	Arnd
