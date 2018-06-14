Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415xh019spzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 18:32:29 +1000 (AEST)
Date: Thu, 14 Jun 2018 10:32:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
 Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Don Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <frederic@kernel.org>,
 Babu Moger <babu.moger@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
In-Reply-To: <20180614123250.230667f6@roar.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.21.1806141029070.1581@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
 <20180613084219.GT12258@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
 <20180613215225.2a938abc@roar.ozlabs.ibm.com>
 <20180614013117.GC22652@voyager>
 <20180614123250.230667f6@roar.ozlabs.ibm.com>
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

On Thu, 14 Jun 2018, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 18:31:17 -0700
> > I could look into creating the library for
> > common code and relocate the hpet watchdog into arch/x86 for the hpet-
> > specific parts.
> 
> If you can investigate that approach, that would be appreciated. I hope
> I did not misunderstand you there, Thomas.

I'm not against cleanups and consolidation, quite the contrary.

But this stuff just adds new infrastructure w/o showing that it's actually
a cleanup and consolidation.

Thanks,

	tglx
