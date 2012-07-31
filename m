Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 223BB2C04A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:25:33 +1000 (EST)
Subject: Re: [PATCH v8 2/7] powerpc/smp: add generic_set_cpu_up() to set
 cpu_state as CPU_UP_PREPARE
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342788159-27529-3-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 31 Jul 2012 09:24:28 -0500
Message-Id: <51671362-4E74-43F2-B9AF-F5C376F51038@kernel.crashing.org>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <1342788159-27529-3-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2012, at 7:42 AM, Zhao Chenhui wrote:

> In the case of cpu hotplug, the cpu_state should be set to =
CPU_UP_PREPARE when kicking cpu.
> Otherwise, the cpu_state is always CPU_DEAD after calling =
generic_set_cpu_dead(), which
> makes the delay in generic_cpu_die() not happen.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> arch/powerpc/include/asm/smp.h |    1 +
> arch/powerpc/kernel/smp.c      |   12 +++++++++++-
> 2 files changed, 12 insertions(+), 1 deletions(-)

applied to next

- k=
