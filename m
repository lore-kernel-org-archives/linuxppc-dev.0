Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8226B6FC5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:23:10 +1100 (EST)
Subject: Re: [PATCH 7/9] powerpc/mpc8548cds: fix alias in mpc8548si-pre.dtsi
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024805-15926-6-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 16 Mar 2012 15:23:06 -0500
Message-Id: <94CF0569-2407-408C-884E-5B2F39E8E4BF@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <1331024805-15926-6-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:06 AM, Zhao Chenhui wrote:

> Correct ethernet1 and add ethernet2 and ethernet3.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)

applied

- k
