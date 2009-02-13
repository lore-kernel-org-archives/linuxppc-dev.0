Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DDEBDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:12:28 +1100 (EST)
Subject: Re: [PATCH 2/7][RFC] powerpc64: port of the function graph tracer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20090212011342.880486000@goodmis.org>
References: <20090212011051.265346435@goodmis.org>
	<20090212011342.880486000@goodmis.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 15:12:00 +1100
Message-Id: <1234498320.26036.33.camel@pasglop>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, 2009-02-11 at 20:10 -0500, Steven Rostedt wrote:
> 
> +# timers used by tracing
> +CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
>  endif

That means no tracing of the timer interrupts etc... maybe we should
just move the specific function that we don't want traced out to a
separate file ? 

Appart from that, it looks ok, though I might have missed something :-)

Cheers,
Ben.
