Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw9xn1bvLzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 06:08:13 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qw9xm4S88z9t6S
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 06:08:12 +1000 (AEST)
Date: Wed, 27 Apr 2016 22:08:08 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chris J Arges <chris.j.arges@canonical.com>
cc: Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jessica Yu <jeyu@redhat.com>, Vojtech Pavlik <vojtech@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <kernel@kyup.com>
Subject: Re: [PATCH v2] livepatch: Add some basic LivePatch documentation
In-Reply-To: <20160426114402.GA30334@canonical.com>
Message-ID: <alpine.LNX.2.00.1604272204260.27368@cbobk.fhfr.pm>
References: <1461597275-32120-1-git-send-email-pmladek@suse.com>
 <20160426114402.GA30334@canonical.com>
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

On Tue, 26 Apr 2016, Chris J Arges wrote:

[ ... snip ... ]
> > +  + Kretprobes using the ftrace framework conflict with the patched
> 
>  +  + Kretprobes using the ftrace framework conflicts with the patched

Chris,

I've incorporated all your feedback except for this one; are you really 
sure about it? 'kretprobes' is plural form in this sentence, so what's the 
rationale for your proposed change?

Thanks,

-- 
Jiri Kosina
SUSE Labs
