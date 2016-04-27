Return-Path: <jeyu@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw7y26zFZzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 04:38:18 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qw7y23zX8z9t6X
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 04:38:18 +1000 (AEST)
Date: Wed, 27 Apr 2016 14:38:11 -0400
From: Jessica Yu <jeyu@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <kernel@kyup.com>
Subject: Re: livepatch: Add some basic LivePatch documentation
Message-ID: <20160427183811.GA9847@packer-debian-8-amd64.digitalocean.com>
References: <1461597275-32120-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1461597275-32120-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+++ Petr Mladek [25/04/16 17:14 +0200]:
>LivePatch framework deserves some documentation, definitely.
>This is an attempt to provide some basic info. I hope that
>it will be useful for both LivePatch producers and also
>potential developers of the framework itself.
>
>Signed-off-by: Petr Mladek <pmladek@suse.com>

Nice work Petr. I read through it and didn't notice any other
additional issues. With Chris', Balbir's and Josh's comments taken
into account:

Acked-by: Jessica Yu <jeyu@redhat.com>
