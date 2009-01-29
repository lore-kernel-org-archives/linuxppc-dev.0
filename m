Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 766B4DE169
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:06:50 +1100 (EST)
Message-Id: <E90E8F9C-5FC4-4D0A-86F3-C0114A16E1E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090119113329.9225.83409.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/3] powerpc/86xx: Extend GE Fanuc GPIO driver for the
	SBC310
Date: Wed, 28 Jan 2009 23:06:38 -0600
References: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
	<20090119113329.9225.83409.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 19, 2009, at 5:33 AM, Martyn Welch wrote:

> This patch adds basic support for the 6 GPIO lines found on GE  
> Fanucs SBC310 to the GE Fanuc GPIO driver.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/configs/86xx/gef_sbc310_defconfig |    2 +
> arch/powerpc/platforms/86xx/gef_gpio.c         |   36 +++++++++++++++ 
> ++++++---
> 2 files changed, 32 insertions(+), 6 deletions(-)


applied to next

- k
