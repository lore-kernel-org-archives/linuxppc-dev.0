Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0196.hostedemail.com
 [216.40.44.196])
 by lists.ozlabs.org (Postfix) with ESMTP id CF67A1A041B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 02:49:06 +1000 (AEST)
Date: Thu, 18 Jun 2015 12:49:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/4] ppc64 FTRACE_WITH_REGS implementation
Message-ID: <20150618124900.7a57dff7@gandalf.local.home>
In-Reply-To: <20150618162107.GB6546@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
 <20150618162107.GB6546@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Jun 2015 18:21:07 +0200
Torsten Duwe <duwe@lst.de> wrote:

> +	
>  _GLOBAL(ftrace_stub)
> +	nop
> +	nop
> +.localentry ftrace_stub,.-ftrace_stub	

You might want to run checkpatch and fix your whitespace errors.

-- Steve

>  	blr
>  #else
>  _GLOBAL_TOC(_mcount)
> @@ -1211,12 +1286,12 @@ _GLOBAL(ftrace_stub)
