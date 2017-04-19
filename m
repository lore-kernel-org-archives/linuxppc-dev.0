Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0036.hostedemail.com
 [216.40.44.36])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w76Bs2YKvzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:58:28 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 39F7A211562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 02:49:59 +0000 (UTC)
Date: Tue, 18 Apr 2017 22:49:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, mpe@ellerman.id.au,
 mingo@redhat.com
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
Message-ID: <20170418224953.685943a3@grimm.local.home>
In-Reply-To: <58F6C088.8020304@gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <58F6C088.8020304@gmail.com>
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

On Tue, 18 Apr 2017 18:42:32 -0700
Frank Rowand <frowand.list@gmail.com> wrote:

> And of course the other issue with using tracepoints is the extra space
> required to hold the tracepoint info.  With the pr_debug() approach, the
> space usage can be easily removed for a production kernel via a config
> option.

Now if you are saying you want to be able to enable debugging without
the tracing infrastructure I would agree. As the tracing infrastructure
is large. But I'm working on shrinking it more.

> 
> Tracepoints are wonderful technology, but not always the proper tool to
> use for debug info.

But if you are going to have tracing enabled regardless, adding a few
more tracepoints isn't going to make the difference.

-- Steve

> 
> > If Rob wants to convert printk() style data to trace data (and I can't
> > convince him otherwise) then I will have further comments on this specific
> > patch.
> > 
