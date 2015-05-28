Return-Path: <ralf@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id 873FA1A18A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 00:07:56 +1000 (AEST)
Received: from localhost.localdomain ([127.0.0.1]:59076 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S27013049AbbE1N7nyQdHz (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Thu, 28 May 2015 15:59:43 +0200
Date: Thu, 28 May 2015 15:59:06 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@ezchip.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhang Zhen <zhenzhang.zhang@huawei.com>,
 David Rientjes <rientjes@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nathan Lynch <nathan_lynch@mentor.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 Hugh Dickins <hughd@google.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/hugetlb: remove arch_prepare/release_hugepage
 from arch headers
Message-ID: <20150528135905.GD1179@linux-mips.org>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
 <1432813957-46874-4-git-send-email-dingel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432813957-46874-4-git-send-email-dingel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 28, 2015 at 01:52:35PM +0200, Dominik Dingel wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>
