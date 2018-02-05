Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZZpx4N8XzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 15:48:25 +1100 (AEDT)
Date: Mon, 5 Feb 2018 15:48:21 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
 egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
 mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
 robh@kernel.org, sboyd@codeaurora.org, will.deacon@arm.com,
 tony@atomide.com, npiggin@gmail.com, yamada.masahiro@socionext.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/20] KVM: PPC: Book3S PR: Fix broken select due to
 misspelling
Message-ID: <20180205044821.3zvs7cfhdr3eu2qa@oak.ozlabs.ibm.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-3-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180205012146.23981-3-ulfalizer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2018 at 02:21:14AM +0100, Ulf Magnusson wrote:
> Commit 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code
> on non-pseries platforms") added a reference to the globally undefined
> symbol PPC_SERIES. Looking at the rest of the commit, PPC_PSERIES was
> probably intended.
> 
> Change PPC_SERIES to PPC_PSERIES.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>

Which tree is this series going into?

Paul.
