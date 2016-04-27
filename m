Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw9sW14xczDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 06:04:31 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qw9sV3djjz9t6M
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 06:04:28 +1000 (AEST)
Date: Wed, 27 Apr 2016 22:04:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>,
 Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <kernel@kyup.com>
Subject: Re: [PATCH v2] livepatch: Add some basic LivePatch documentation
In-Reply-To: <1461597275-32120-1-git-send-email-pmladek@suse.com>
Message-ID: <alpine.LNX.2.00.1604272203220.27368@cbobk.fhfr.pm>
References: <1461597275-32120-1-git-send-email-pmladek@suse.com>
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

On Mon, 25 Apr 2016, Petr Mladek wrote:

> LivePatch framework deserves some documentation, definitely.
> This is an attempt to provide some basic info. I hope that
> it will be useful for both LivePatch producers and also
> potential developers of the framework itself.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Good stuff, thanks.

I've incorporated most of the feedback (*) and pushed out to 
livepatching.git#for-4.7/livepatching-doc so everybody please send any 
followup documentation patches on top of that branch.

-- 
Jiri Kosina
SUSE Labs
