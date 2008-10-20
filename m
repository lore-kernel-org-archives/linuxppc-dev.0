Return-Path: <fweisbec@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 448C8DDF92
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 04:42:40 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so934174nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 10:42:38 -0700 (PDT)
Message-ID: <c62985530810201042v4b3eed0ah62de285c64b2c0ba@mail.gmail.com>
Date: Mon, 20 Oct 2008 19:42:38 +0200
From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
In-Reply-To: <20081020170808.GB7249@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
	<20081016150106.6ddf7e46@zod.rchland.ibm.com>
	<alpine.DEB.1.10.0810201222570.3760@gandalf.stny.rr.com>
	<20081020170808.GB7249@yoda.jdub.homelinux.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2008/10/20 Josh Boyer <jwboyer@linux.vnet.ibm.com>:
> That seems like a good plan.  Should we mark dynamic ftrace as X86 only
> in Kconfig for .28 to prevent people from inadvertently setting it?

Hi Josh.

There are other arch that support ftrace as well like sh or sparc64
(I'm currently working on
an implementation for mips).
So the choice would be better between waiting for a fix or disable
dynamic ftrace
on Kconfig only for PowerPC.
