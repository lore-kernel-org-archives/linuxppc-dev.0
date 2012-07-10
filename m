Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 35E412C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 22:23:47 +1000 (EST)
Subject: Re: [PATCH v2 1/2] powerpc/e500: make load_up_spe a normal fuction
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330564819-11139-1-git-send-email-hong-hua.yin@freescale.com>
Date: Tue, 10 Jul 2012 07:23:41 -0500
Message-Id: <F3020031-62AF-49BF-B380-73FDE22A20B3@kernel.crashing.org>
References: <1330564819-11139-1-git-send-email-hong-hua.yin@freescale.com>
To: Olivia Yin <hong-hua.yin@freescale.com>
Cc: Liu Yu <yu.liu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 29, 2012, at 7:20 PM, Olivia Yin wrote:

> From: Liu Yu <yu.liu@freescale.com>
>=20
> So that we can call it when improving SPE switch like book3e did for =
fp switch.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> Signed-off-by: Olivia Yin <hong-hua.yin@freescale.com>
> ---
> v2: 	add Signed-off-by
>=20
> arch/powerpc/kernel/head_fsl_booke.S |   23 ++++++-----------------
> 1 files changed, 6 insertions(+), 17 deletions(-)

applied to next

- k=
