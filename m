Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwKS73j6NzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:46:31 +1000 (AEST)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qwKS65hgZz9t6M
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 11:46:30 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id 206so27413082pfu.0
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2016 18:46:30 -0700 (PDT)
Subject: Re: [PATCH v2] livepatch: Add some basic LivePatch documentation
To: Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>
References: <1461597275-32120-1-git-send-email-pmladek@suse.com>
 <alpine.LNX.2.00.1604272203220.27368@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1604272208130.27368@cbobk.fhfr.pm>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>,
 Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linuxppc-dev@ozlabs.org,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <kernel@kyup.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57216B6A.20302@gmail.com>
Date: Thu, 28 Apr 2016 11:46:18 +1000
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1604272208130.27368@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/04/16 06:08, Jiri Kosina wrote:
> On Wed, 27 Apr 2016, Jiri Kosina wrote:
> 
>> I've incorporated most of the feedback (*) and pushed out to 
>> livepatching.git#for-4.7/livepatching-doc so everybody please send any 
>> followup documentation patches on top of that branch.
> 
> (*) Balbir, some of your comments were a bit too vague; if you could turn 
> them into actual patch on top of what's currently in git, that'd be 
> helpful
> 

Hi, Jiri

Thanks! I'll try to do that -- I'll add it on my TODO list.

Balbir Singh.
