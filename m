Return-Path: <fweisbec@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 7CCB2DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 08:47:49 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so945900eyi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 14:47:46 -0700 (PDT)
Message-ID: <c62985530810201447w10423125wb5800c004de6a73c@mail.gmail.com>
Date: Mon, 20 Oct 2008 23:47:45 +0200
From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
In-Reply-To: <alpine.DEB.1.10.0810201351130.5336@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080906050602.409299112@goodmis.org>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
	<20081016150106.6ddf7e46@zod.rchland.ibm.com>
	<alpine.DEB.1.10.0810201222570.3760@gandalf.stny.rr.com>
	<20081020170808.GB7249@yoda.jdub.homelinux.org>
	<c62985530810201042v4b3eed0ah62de285c64b2c0ba@mail.gmail.com>
	<alpine.DEB.1.10.0810201351130.5336@gandalf.stny.rr.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2008/10/20 Steven Rostedt <rostedt@goodmis.org>:
> I believe MIPS has the same issues as PPC. Doesn't it use a trampoline
> too?

No it doesn't seem to. If I'm not wrong, MIPS uses only the elf
relocation table to relocate
its addresses.

> I want to make the generic code handle trampolines a bit better.

Do you think there could be a generic approach to handles these trampolines?
