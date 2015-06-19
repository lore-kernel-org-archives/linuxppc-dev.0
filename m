Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D1031A0F70
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:49:55 +1000 (AEST)
Message-ID: <1434682195.23771.3.camel@ellerman.id.au>
Subject: Re: [RESEND PATCH 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Jun 2015 12:49:55 +1000
In-Reply-To: <20150618161727.GA6546@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-06-18 at 18:17 +0200, Torsten Duwe wrote:
> Did I miss anything else? I have the notrace optimisations and
> kernel live patching in the queue, which depends on this, so I'd
> really appreciate a comment whether it is acceptable in this form
> or not. Thanks in advance!

Hi Torsten,

Sorry I just haven't had time to look at it this week while I've been doing
linux-next.

I'll try and review it next week.

There's no need to resend, we keep track of things in patchwork:

  http://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=2722


cheers
