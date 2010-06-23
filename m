Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D98F101F28
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:14:28 +1000 (EST)
Date: Wed, 23 Jun 2010 12:14:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 12/40] x86, compat: convert ia32 layer to use
Message-ID: <20100623101402.GA10564@lst.de>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-13-git-send-email-imunsie@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277287401-28571-13-git-send-email-imunsie@au1.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jason Baron <jbaron@redhat.com>, x86@kernel.org,
	Greg Ungerer <gerg@uclinux.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any reason we need to differenciate between COMPAT_SYSCALL_DEFINE and
ARCH_COMPAT_SYSCALL_DEFINE?  We don't need this for native system calls,
so I can't see the reason to do it for compat system calls.
