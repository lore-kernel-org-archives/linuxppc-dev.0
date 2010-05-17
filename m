Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9861CB8232
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 01:56:10 +1000 (EST)
Subject: Re: [PATCH] powerpc/83xx: Add MCU LEDs support for MPC837xRDB and
	MPC8315RDB boards
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100502172705.GA22021@oksana.dev.rtsoft.ru>
Date: Mon, 17 May 2010 10:55:52 -0500
Message-Id: <CC0FBB03-85E6-4875-9ABF-C7A9BA3C8AC1@kernel.crashing.org>
References: <20100502172705.GA22021@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 2, 2010, at 12:27 PM, Anton Vorontsov wrote:

> There are two front-panel LEDs on MPC837xRDB and MPC8315RDB boards: PWR
> and HDD. After adding appropriate nodes we can program these LEDs from
> kernel and user space.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8315erdb.dts     |   14 ++++++++++++++
> arch/powerpc/boot/dts/mpc8377_rdb.dts     |   14 ++++++++++++++
> arch/powerpc/boot/dts/mpc8378_rdb.dts     |   14 ++++++++++++++
> arch/powerpc/boot/dts/mpc8379_rdb.dts     |   14 ++++++++++++++
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> 6 files changed, 58 insertions(+), 0 deletions(-)

applied to next

- k
