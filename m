Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A95782C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 23:17:18 +1000 (EST)
Subject: Re: [PATCH 1/4] powepc/booke: Separate out E.HV check and ivor setup
 code.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341838531-17023-1-git-send-email-Varun.Sethi@freescale.com>
Date: Fri, 3 Aug 2012 11:34:26 -0500
Message-Id: <A92C46D7-9C28-4116-A342-82D863E2AAEA@kernel.crashing.org>
References: <1341838531-17023-1-git-send-email-Varun.Sethi@freescale.com>
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


On Jul 9, 2012, at 7:55 AM, Varun Sethi wrote:

> Move the E.HV check and CPU_FTR_EMB_HV flag manipulation to the cpu =
setup code.
> Create a separate routine for E.HV ivors setup.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |   29 =
++++++++++++++++++++++++++---
> arch/powerpc/kernel/head_fsl_booke.S      |   18 ++++--------------
> 2 files changed, 30 insertions(+), 17 deletions(-)

applied to next

- k=
