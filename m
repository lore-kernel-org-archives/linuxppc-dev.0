Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 26F7D1400A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Mar 2014 09:14:16 +1100 (EST)
Date: Fri, 28 Mar 2014 15:14:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [RESEND][PATCH 0/2] Cleanup asm/scatterlist.h
Message-Id: <20140328151412.9d3ce44ee4c5ad3b1c75751d@linux-foundation.org>
In-Reply-To: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Lennox Wu <lennox.wu@gmail.com>, Chen Liqin <liqin.linux@gmail.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com,
 Russell King <linux@arm.linux.org.uk>, linux-scsi@vger.kernel.org,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-s390@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
 Mikael Starvik <starvik@axis.com>, linux-m32r@ml.linux-m32r.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 22 Mar 2014 11:13:50 -0700 Laura Abbott <lauraa@codeaurora.org> wrote:

> I haven't gotten many responses so I'm going to try sending again
> (this time with a cover letter which I probably should have done in
> the first place...)
> 
> ARCH_HAS_SG_CHAIN is currently defined as needed in asm/scatterlist.h.
> It was suggested[1] that this should probably be a proper Kconfig.
> At the same time, we can clean up most of the asm/scatterlist.h files
> to reduce redundancy. This makes parisc the only architecture that still
> has an asm/scatterlist.h file due to the #define sg_virt_addr (which
> could probably be cleaned up further still)
> 
> Andrew, once we get a few more Acked-bys can we take this through your tree
> as suggested by Will?

Grabbed.  It's super late for 3.15-rc1 and I'm thinking of merging this
in 3.16-rc1.  Or I can maybe squeeze it into 3.15-rc2 is there's an
immediatish need for it?
