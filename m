Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2BB372C03C0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 23:17:32 +1000 (EST)
Subject: Re: [PATCH 3/4] powerpc/booke: Separate out restore_e5500/setup_e5500
 routines.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341838911-17157-1-git-send-email-Varun.Sethi@freescale.com>
Date: Fri, 3 Aug 2012 11:38:41 -0500
Message-Id: <624E2ACB-C865-4BDA-9CA5-11C4E82288D1@kernel.crashing.org>
References: <1341838911-17157-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2012, at 8:01 AM, Varun Sethi wrote:

> For the 64 bit case separate out e5500 cpu_setup and cpu_restore =
functions.
> The cpu_setup function (for the primary core) is passed the cpu_spec =
pointer,
> which is not there in case of the cpu_restore function. Also, in our =
case
> we will have to manipulate the CPU_FTR_EMB_HV flag on the the primary =
core. =20
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |   38 =
++++++++++++++++++++++++----
> arch/powerpc/kernel/exceptions-64e.S      |   18 +------------
> 2 files changed, 34 insertions(+), 22 deletions(-)

applied to next

- k=
