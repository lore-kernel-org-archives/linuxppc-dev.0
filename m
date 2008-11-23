Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44F44DDDF8
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 23:50:26 +1100 (EST)
Date: Sun, 23 Nov 2008 13:49:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/1] powerpc: make mcount a stub for dynamic ftrace
Message-ID: <20081123124958.GM29663@elte.hu>
References: <20081120215541.489725873@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120215541.489725873@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Paul,
> 
> I have one more patch. I added it to the end of the ppc/ftrace 
> branch. The new way of handling the finding of mcounts means we do 
> not need to do anything in the mcount call itself. It should just be 
> a stub and when ftrace is enabled, it will change the caller sites 
> to call something other than mcount.
> 
> The following patches are in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> 
>     branch: ppc/ftrace

i've also pulled the ppc/ftrace branch into tip/tracing/powerpc, and 
added it to ftrace-next's linux-next integration rules.

So if Paul gives the green light that the commits have the right 
structure, we can freeze down the branch and the SHA1's and integrate 
it into ftrace-next. (which is integrated in linux-next after the 
powerpc tree so should be all fine in terms of merge ordering)

	Ingo
