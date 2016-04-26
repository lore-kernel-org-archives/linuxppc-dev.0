Return-Path: <jpoimboe@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvcmS0fNTzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 08:13:12 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qvcmR5hvXz9t61
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2016 08:13:11 +1000 (AEST)
Date: Tue, 26 Apr 2016 17:13:07 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <kernel@kyup.com>
Subject: Re: [PATCH v2] livepatch: Add some basic LivePatch documentation
Message-ID: <20160426221307.hmtfa7n6uokipwru@treble>
References: <1461597275-32120-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1461597275-32120-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2016 at 05:14:35PM +0200, Petr Mladek wrote:
> LivePatch framework deserves some documentation, definitely.
> This is an attempt to provide some basic info. I hope that
> it will be useful for both LivePatch producers and also
> potential developers of the framework itself.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

My only comment is s/LivePatch/livepatch/ here and in the subject.
Otherwise it looks great to me.  Really nice work!

-- 
Josh
