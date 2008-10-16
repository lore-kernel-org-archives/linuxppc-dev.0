Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id E760EDDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 05:16:22 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so51995qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 11:16:21 -0700 (PDT)
Date: Thu, 16 Oct 2008 14:14:52 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
Message-ID: <20081016181452.GA29739@yoda.jdub.homelinux.org>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080906120346.GA30964@elte.hu>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 06, 2008 at 02:03:47PM +0200, Ingo Molnar wrote:
>
>* Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> I spent the day chasing a bug that would hang PPC on boot up when 
>> ftrace is configured in. I found that it was simply a stupid bug I did 
>> to handle the non MCOUNT_RECORD case. Since I was testing only on x86, 
>> and the MCOUNT_RECORD is automatically set for dynamic ftrace if it is 
>> available, I did not test the case where MCOUNT_RECORD was not set.
>> 
>> I have not finished porting MCOUNT_RECORD to PPC, but have found that 
>> it has caused some issues for archs that do not support it yet.
>> 
>> This patch series handles these cases.
>
>applied to tip/tracing/ftrace, thanks Steve.

Are these two merged yet?  I just spent the better part of the morning
trying to figure out why various Fedora kernels based on 2.6.27-rcX and
2.6.27 final hung on my G5 and finally got one booting with FTRACE
disabled.

josh
