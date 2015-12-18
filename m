Return-Path: <dave@stgolabs.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C345B1A1A40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2015 04:13:18 +1100 (AEDT)
Date: Fri, 18 Dec 2015 09:12:50 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
Message-ID: <20151218171250.GE17386@linux-uzut.site>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've left this series testing overnight on a power7 box and so far so good,
nothing has broken.
