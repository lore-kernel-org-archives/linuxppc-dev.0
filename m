Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90C54DDF90
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:37:22 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1M1ohh-0005m5-Ry
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 23:31:01 +0200
Date: Wed, 6 May 2009 23:29:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090506212913.GC4861@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@kernel.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Markus Gutschke (顧孟勤) <markus@google.com> wrote:

> On Sat, Feb 28, 2009 at 10:23, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

> > And I guess the seccomp interaction means that this is 
> > potentially a 2.6.29 thing. Not that I know whether anybody 
> > actually _uses_ seccomp. It does seem to be enabled in at least 
> > Fedora kernels, but it might not be used anywhere.
> 
> In the Linux version of Google Chrome, we are currently working on 
> code that will use seccomp for parts of our sandboxing solution.

That's a pretty interesting usage. What would be fallback mode you 
are using if the kernel doesnt have seccomp built in? Completely 
non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?

	Ingo
