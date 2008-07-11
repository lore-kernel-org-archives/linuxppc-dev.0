Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH -next-20080709] fixup stop_machine use cpu mask vs ftrace
Date: Fri, 11 Jul 2008 16:43:29 +1000
References: <200807081801.38026.rusty@rustcorp.com.au>
	<200807081756.47140.rusty@rustcorp.com.au>
	<for-27-patch0-1@bga.com>
In-Reply-To: <for-27-patch0-1@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807111643.30233.rusty@rustcorp.com.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 July 2008 07:07:57 Milton Miller wrote:
> Hi Rusty, Ingo.
>
> Rusty's patch [PATCH 3/3] stop_machine: use cpu mask rather than magic
> numbers didn't find kernel/trace/ftrace.c in -next, causing an immediate
> almost NULL pointer dereference in ftrace_dynamic_init.

Yes, I'm switching the patches around, so it does the transition correctly. 
Introduces a new stop_machine() fn with the new interface and deprecates the 
old stop_machine_run().  We can remove stop_machine_run() after everyone is 
switched.

Thanks,
Rusty.
