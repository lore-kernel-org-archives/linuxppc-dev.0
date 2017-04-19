Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0026.hostedemail.com
 [216.40.44.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w764V0ZKyzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:52:56 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id AC65628ED2A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 02:47:08 +0000 (UTC)
Date: Tue, 18 Apr 2017 22:46:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, mpe@ellerman.id.au,
 mingo@redhat.com
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
Message-ID: <20170418224657.1b7ed057@grimm.local.home>
In-Reply-To: <58F6AA35.2040902@gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com>
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

On Tue, 18 Apr 2017 17:07:17 -0700
Frank Rowand <frowand.list@gmail.com> wrote:


> As far as I know, there is no easy way to combine trace data and printk()
> style data to create a single chronology of events.  If some of the
> information needed to debug an issue is trace data and some is printk()
> style data then it becomes more difficult to understand the overall
> situation.

You mean like:

 # echo 1 > /sys/kernel/debug/tracing/events/printk/console/enable

Makes all printks also go into the ftrace ring buffer.

-- Steve

> 
> If Rob wants to convert printk() style data to trace data (and I can't
> convince him otherwise) then I will have further comments on this specific
> patch.
> 
