Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92EB31A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 05:35:18 +1000 (EST)
Message-ID: <53C96946.4090304@zytor.com>
Date: Fri, 18 Jul 2014 11:36:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>, Richard Weinberger <richard@nod.at>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
 <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
 <20140718101416.GB1818@arm.com> <53C8F4DF.8020103@nod.at>
 <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
In-Reply-To: <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Tony Luck <tony.luck@intel.com>, Nathan Lynch <Nathan_Lynch@mentor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2014 09:53 AM, Andy Lutomirski wrote:
> 
> Splitting this will be annoying: I'd probably have to add a flag asking for
> the new behavior, update all the arches, then remove the flag.  The chance
> of screwing up bisectability in the process seems pretty high.  This seems
> like overkill for a patch that mostly deletes code.
> 
> Akpm, can you take this?
> 

I'm fine with it as-is.

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
