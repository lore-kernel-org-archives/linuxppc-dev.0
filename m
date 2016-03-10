Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15BA11A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 20:09:09 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9779514030E
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 20:09:08 +1100 (AEDT)
Date: Thu, 10 Mar 2016 10:09:00 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>,
 Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] livepatch: Add some basic LivePatch documentation
In-Reply-To: <1457532106-30925-1-git-send-email-pmladek@suse.com>
Message-ID: <alpine.LNX.2.00.1603101005480.3656@cbobk.fhfr.pm>
References: <1457532106-30925-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Mar 2016, Petr Mladek wrote:

> LivePatch framework deserves some documentation, definitely.
> This is an attempt to provide some basic info. I hope that
> it will be useful for both LivePatch producers and also
> potential developers of the framework itself.

Thanks for starting the efforts; this is really needed if we want the 
infrastructure to be used also by someone else than its developers :)

[ ... snip ... ]
> +7. Limitations
> +==============

Miroslav Benes, who is working on creating the actual patches we are 
shipping for our kernels, should already have a decent cheat-sheet 
regarding things that the patch author should be extra careful when 
creating a patch (inlining and other gcc optimizations such as isra, 
functions that use switch_to(), percpu, ...).

I am not really sure whether these should go to limitations, or maybe 
they'd better be placed into a separate chapter, but I'd really like to 
see it included.

Thanks,

-- 
Jiri Kosina
SUSE Labs
