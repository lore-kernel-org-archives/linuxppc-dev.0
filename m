Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 1A8B3B7098
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:36:18 +1000 (EST)
Received: by bwz1 with SMTP id 1so2342486bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 03:36:16 -0700 (PDT)
Date: Wed, 23 Jun 2010 12:36:21 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/40] x86, compat: convert ia32 layer to use
Message-ID: <20100623103619.GC5242@nowhere>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-13-git-send-email-imunsie@au1.ibm.com>
	<20100623101402.GA10564@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100623101402.GA10564@lst.de>
Cc: Jason Baron <jbaron@redhat.com>, x86@kernel.org,
	Greg Ungerer <gerg@uclinux.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 23, 2010 at 12:14:02PM +0200, Christoph Hellwig wrote:
> Any reason we need to differenciate between COMPAT_SYSCALL_DEFINE and
> ARCH_COMPAT_SYSCALL_DEFINE?  We don't need this for native system calls,
> so I can't see the reason to do it for compat system calls.
> 


I think we wanted that to keep the sys32_ prefixed based naming, to avoid
collisions with generic compat handler names.
