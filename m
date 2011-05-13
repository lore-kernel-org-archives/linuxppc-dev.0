Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9382CB6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 01:27:45 +1000 (EST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20110513145737.GC32688@elte.hu>
References: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
	<1305294935.2466.64.camel@twins>  <20110513145737.GC32688@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 May 2011 17:27:23 +0200
Message-ID: <1305300443.2466.77.camel@twins>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter
	Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, agl@chromium.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-13 at 16:57 +0200, Ingo Molnar wrote:
> this is a security mechanism

Who says? and why would you want to unify two separate concepts only to
them limit it to security that just doesn't make sense.

Either you provide a full on replacement for notifier chain like things
or you don't, only extending trace events in this fashion for security
is like way weird.

Plus see the arguments Eric made about stacking stuff, not only security
schemes will have those problems.
