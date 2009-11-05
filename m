Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7ACBBB7BF0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:10:28 +1100 (EST)
Subject: Re: [PATCH 3/5] powerpc/86xx: Enable NVRAM on GE Fanuc's SBC610
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090702161231.31202.87763.stgit@ES-J7S4D2J.amer.consind.ge.com>
Date: Thu, 5 Nov 2009 08:10:18 -0600
Message-Id: <DAE90CFA-DC33-4BF6-9381-35B0BC1D45C4@kernel.crashing.org>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<20090702161231.31202.87763.stgit@ES-J7S4D2J.amer.consind.ge.com>
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

> This patch enables the NVRAM found on the GE Fanuc SBC610
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts           |    6 ++++++
> arch/powerpc/configs/86xx/gef_sbc610_defconfig |    4 ++--
> arch/powerpc/platforms/86xx/Kconfig            |    1 +
> arch/powerpc/platforms/86xx/gef_sbc610.c       |    5 +++++
> 4 files changed, 14 insertions(+), 2 deletions(-)

I assume these still work w/the updates to the other patches?

- k
