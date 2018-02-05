Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZzY53C0VzF0v3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 07:22:49 +1100 (AEDT)
Received: by mail-wm0-x229.google.com with SMTP id f3so43863wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Feb 2018 12:22:49 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 5 Feb 2018 21:22:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andrea Parri <parri.andrea@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>,
 Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
Message-ID: <20180205202242.6ilyjh35byycf3ez@gmail.com>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
 <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

>  
> +config ARCH_HAS_MEMBARRIER_HOOKS
> +	bool

Yeah, so I have renamed this to ARCH_HAS_MEMBARRIER_CALLBACKS, and propagated it 
through the rest of the patches. "Callback" is the canonical name, and I also 
cringe every time I see 'hook'.

Please let me know if there are any big objections against this minor cleanup.

Thanks,

	Ingo
