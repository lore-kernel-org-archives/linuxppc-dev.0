Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4576B7BCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 10:41:38 +1100 (EST)
Subject: Re: [PATCH 1/6] powerpc: tracing: Add powerpc tracepoints for
	interrupt entry and exit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rostedt@goodmis.org
In-Reply-To: <1256680832.26028.469.camel@gandalf.stny.rr.com>
References: <20091027044742.GB3085@kryten>
	<1256680832.26028.469.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Oct 2009 10:41:28 +1100
Message-ID: <1256686888.11607.131.camel@pasglop>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-27 at 18:00 -0400, Steven Rostedt wrote:
> I have no problem with any of these changes. I guess this is up to Ben
> and company to decide the rest.

I'll stick them into my -next branch, hopefully today or tomorrow.

The ppc "perf_events" specific bits are going to go via paulus first.

Cheers,
Ben.
