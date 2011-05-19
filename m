Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D644B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:05:32 +1000 (EST)
Subject: Re: [PATCH 02/13] powerpc/e500: SPE register saving: take arbitrary
	struct offset
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110517233628.GA3542@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:05:24 -0500
Message-Id: <C5B9206A-4F42-4C3C-BBF3-7842DBF296D1@kernel.crashing.org>
References: <20110517233628.GA3542@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 17, 2011, at 6:36 PM, Scott Wood wrote:

> Previously, these macros hardcoded THREAD_EVR0 as the base of the save
> area, relative to the base register passed.  This base offset is now
> passed as a separate macro parameter, allowing reuse with other SPE
> save areas, such as used by KVM.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This is a resending of =
http://www.spinics.net/lists/kvm-ppc/msg02672.html
>=20
> Kumar, please ack to go via kvm.
>=20
> arch/powerpc/include/asm/ppc_asm.h   |   28 =
++++++++++++++++------------
> arch/powerpc/kernel/head_fsl_booke.S |    6 +++---
> 2 files changed, 19 insertions(+), 15 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

[ Alex, let me know if you want this via my powerpc.git tree or your kvm =
tree ]

- k
