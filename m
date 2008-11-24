Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18730.4823.146518.37665@drongo.ozlabs.ibm.com>
Date: Mon, 24 Nov 2008 13:35:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/5] powerpc/ppc32: ftrace,
	dynamic ftrace to handle modules
In-Reply-To: <20081120191149.959614508@goodmis.org>
References: <20081120190948.057007623@goodmis.org>
	<20081120191149.959614508@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt writes:

> This patch performs the necessary trampoline calls to handle
> modules with dynamic ftrace on 32 bit PowerPC.

Looks OK except for the need to call flush_icache_range after
probe_kernel_write, like in the 64-bit case.

Paul.
