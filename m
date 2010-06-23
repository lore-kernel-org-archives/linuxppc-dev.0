Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id E0E39B6EF7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 05:45:51 +1000 (EST)
Subject: Re: [PATCH 08/40] tracing: remove syscall bitmaps in preparation
	for compat support
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Baron <jbaron@redhat.com>
In-Reply-To: <20100623193455.GE2680@redhat.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-9-git-send-email-imunsie@au1.ibm.com>
	<1277306204.9181.43.camel@gandalf.stny.rr.com>
	<20100623191454.GC2680@redhat.com> <20100623193455.GE2680@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 23 Jun 2010 15:45:47 -0400
Message-ID: <1277322347.9181.54.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Masami Hiramatsu <mhiramat@redhat.com>
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-06-23 at 15:34 -0400, Jason Baron wrote:

> Actually, looking at this further, what we probably want to do change
> the "int nb_args" field, which is already in syscall_metadata into a bit
> field. nb_args I think can be at most 6, or 3 bits, and we only need 4
> bits for storing the enabled/disabled data, so we could even make it a
> char. Thus, actually saving space with this patch :) (at least as far as
> the syscall_metadata field is concerned).

Yeah, I'm fine with turning that into a count/flags field.

-- Steve
