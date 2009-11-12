Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8128BB7B63
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 01:04:17 +1100 (EST)
Subject: Re: [PATCH 4/5] powerpc/86xx: Support for NVRAM on GE Fanuc's SBC310
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090702161237.31202.95547.stgit@ES-J7S4D2J.amer.consind.ge.com>
Date: Thu, 12 Nov 2009 08:04:04 -0600
Message-Id: <6E6CF6FE-FCF9-4BAC-8DA3-52FB50D59BB6@kernel.crashing.org>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<20090702161237.31202.95547.stgit@ES-J7S4D2J.amer.consind.ge.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 2, 2009, at 11:12 AM, Martyn Welch wrote:

> Add support for NVRAM on GE Fanuc's SBC310.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc310.dts           |    6 ++++++
> arch/powerpc/configs/86xx/gef_sbc310_defconfig |    4 ++--
> arch/powerpc/platforms/86xx/Kconfig            |    1 +
> arch/powerpc/platforms/86xx/gef_sbc310.c       |    5 +++++
> 4 files changed, 14 insertions(+), 2 deletions(-)

applied to next

- k
