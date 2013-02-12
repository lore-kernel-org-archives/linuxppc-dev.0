Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 82EC92C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 07:07:17 +1100 (EST)
Subject: Re: [PATCH 1/4] powerpc/fsl: msi: sparse fixes
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1354318502-367-1-git-send-email-kim.phillips@freescale.com>
Date: Tue, 12 Feb 2013 14:07:15 -0600
Message-Id: <B793C26E-BE7C-4AA2-B95B-3B492FD314E5@kernel.crashing.org>
References: <1354318502-367-1-git-send-email-kim.phillips@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 30, 2012, at 5:34 PM, Kim Phillips wrote:

> arch/powerpc/sysdev/fsl_msi.c:31:1: warning: symbol 'msi_head' was not =
declared. Should it be static?
> arch/powerpc/sysdev/fsl_msi.c:138:40: warning: incorrect type in =
argument 1 (different base types)
> arch/powerpc/sysdev/fsl_msi.c:138:40:    expected restricted __be64 =
const [usertype] *p
> arch/powerpc/sysdev/fsl_msi.c:138:40:    got unsigned long long const =
[usertype] *[assigned] reg
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

applied 1-4 to next

- k=
