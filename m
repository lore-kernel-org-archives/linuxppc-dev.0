Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B86A2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 04:02:02 +1000 (EST)
Subject: Re: [PATCH 4/4] powerpc/booke: Add CPU_FTR_EMB_HV check for e5500.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341839041-17223-1-git-send-email-Varun.Sethi@freescale.com>
Date: Fri, 3 Aug 2012 13:01:45 -0500
Message-Id: <03F34497-603F-4F39-A240-0845A9A6965A@kernel.crashing.org>
References: <1341839041-17223-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2012, at 8:04 AM, Varun Sethi wrote:

> Added CPU_FTR_EMB_HV feature check for e550.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

[ fixed typo e550 -> e5500 ]

applied to next

- k
