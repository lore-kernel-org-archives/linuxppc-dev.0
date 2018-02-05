Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZzzF4J0wzF0s2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 07:42:01 +1100 (AEDT)
Date: Mon, 5 Feb 2018 20:32:08 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 maged michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrea Parri <parri.andrea@gmail.com>,
 "Russell King, ARM Linux" <linux@armlinux.org.uk>,
 Greg Hackmann <ghackmann@google.com>,
 Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86 <x86@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1407075321.16343.1517862728006.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180205202242.6ilyjh35byycf3ez@gmail.com>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
 <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
 <20180205202242.6ilyjh35byycf3ez@gmail.com>
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- On Feb 5, 2018, at 3:22 PM, Ingo Molnar mingo@kernel.org wrote:

> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>  
>> +config ARCH_HAS_MEMBARRIER_HOOKS
>> +	bool
> 
> Yeah, so I have renamed this to ARCH_HAS_MEMBARRIER_CALLBACKS, and propagated it
> through the rest of the patches. "Callback" is the canonical name, and I also
> cringe every time I see 'hook'.
> 
> Please let me know if there are any big objections against this minor cleanup.

No objection at all,

Thanks!

Mathieu

> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
