Return-Path: <jglisse@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KYGp2sGNzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 00:54:10 +1000 (AEST)
Date: Mon, 9 Apr 2018 10:53:56 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Vineet Gupta <vgupta@synopsys.com>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Message-ID: <20180409145344.GA3285@redhat.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180409140721.GI21835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180409140721.GI21835@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 09, 2018 at 04:07:21PM +0200, Michal Hocko wrote:
> On Mon 09-04-18 15:57:06, Laurent Dufour wrote:
> > The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
> > per architecture header files. This doesn't allow to make other
> > configuration dependent on it.
> > 
> > This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
> > setting it automatically when architectures was already setting it in
> > header file.
> > 
> > There is no functional change introduced by this series.
> 
> I would just fold all three patches into a single one. It is much easier
> to review that those selects are done properly when you can see that the
> define is set for the same architecture.
> 
> In general, I like the patch. It is always quite painful to track per
> arch defines.

You can also add Reviewed-by: Jérôme Glisse <jglisse@redhat> my grep fu
showed no place that was forgotten.

Cheers,
Jérôme
