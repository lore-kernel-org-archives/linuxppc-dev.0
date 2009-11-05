Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D31B100896
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:58:27 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc/fsl: Make fsl_deep_sleep() usable w/ modules
	and non-83xx builds
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090923185238.GA18755@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 08:58:21 -0600
Message-Id: <AD863DB3-24D6-4325-BB07-3B7E53C34AA7@kernel.crashing.org>
References: <20090923185158.GA29065@oksana.dev.rtsoft.ru>
	<20090923185238.GA18755@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-usb@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 23, 2009, at 1:52 PM, Anton Vorontsov wrote:

> Export is needed for modular builds, and a static inline stub is  
> needed
> for non-MPC83xx builds.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/83xx/suspend.c |    1 +
> include/linux/fsl_devices.h           |    4 ++++
> 2 files changed, 5 insertions(+), 0 deletions(-)

applied to next

- k
