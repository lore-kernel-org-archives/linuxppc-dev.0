Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 911D8B7195
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 02:49:12 +1100 (EST)
Subject: Re: [PATCH 1/2] [v4] powerpc/85xx: p1022ds: disable the NOR flash
 node if video is enabled
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329351948-20581-1-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 10:48:55 -0500
Message-Id: <E802E1FF-366C-41A0-81D2-5ED0D4079BA2@kernel.crashing.org>
References: <1329351948-20581-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 15, 2012, at 6:25 PM, Timur Tabi wrote:

> The Freescale P1022 has a unique pin muxing "feature" where the DIU =
video
> controller's video signals are muxed with 24 of the local bus address =
signals.
> When the DIU is enabled, the bulk of the local bus is disabled, =
preventing
> access to memory-mapped devices like NOR flash and the pixis FPGA.
>=20
> Therefore, if the DIU is going to be enabled, then memory-mapped =
devices on
> the localbus, like NOR flash, need to be disabled.
>=20
> This also means that the localbus is not a 'simple-bus' any more, so =
remove
> that string from the compatible node.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |    6 ++-
> arch/powerpc/platforms/85xx/p1022_ds.c      |   71 =
+++++++++++++++++++++++++++
> 2 files changed, 76 insertions(+), 1 deletions(-)

applied

- k=
