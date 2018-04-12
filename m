Return-Path: <rientjes@google.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MXy82Nk9zDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 06:46:39 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 91-v6so4702796pld.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 13:46:39 -0700 (PDT)
Date: Thu, 12 Apr 2018 13:46:36 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
 Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4] mm: remove odd HAVE_PTE_SPECIAL
In-Reply-To: <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1804121346250.22780@chino.kir.corp.google.com>
References: <20180411110936.GG23400@dhcp22.suse.cz>
 <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
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

On Thu, 12 Apr 2018, Laurent Dufour wrote:

> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
> CONFIG_ARCH_HAS_PTE_SPECIAL.
> 
> There is no functional change introduced by this patch
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
