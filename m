Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w76W80JJszDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:12:35 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g23so1712350pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 20:12:35 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Steven Rostedt <rostedt@goodmis.org>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <20170418224657.1b7ed057@grimm.local.home>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, mpe@ellerman.id.au,
 mingo@redhat.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58F6D588.2050402@gmail.com>
Date: Tue, 18 Apr 2017 20:12:08 -0700
MIME-Version: 1.0
In-Reply-To: <20170418224657.1b7ed057@grimm.local.home>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/17 19:46, Steven Rostedt wrote:
> On Tue, 18 Apr 2017 17:07:17 -0700
> Frank Rowand <frowand.list@gmail.com> wrote:
> 
> 
>> As far as I know, there is no easy way to combine trace data and printk()
>> style data to create a single chronology of events.  If some of the
>> information needed to debug an issue is trace data and some is printk()
>> style data then it becomes more difficult to understand the overall
>> situation.
> 
> You mean like:
> 
>  # echo 1 > /sys/kernel/debug/tracing/events/printk/console/enable
> 
> Makes all printks also go into the ftrace ring buffer.

Thanks!  I was hoping there was going to be an easy answer like this.


> -- Steve
> 
>>
>> If Rob wants to convert printk() style data to trace data (and I can't
>> convince him otherwise) then I will have further comments on this specific
>> patch.
>>
> .
> 
