Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 455E5DDF96
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:08:01 +1000 (EST)
Message-Id: <8E7E138E-E6D7-45FA-885F-380A82ECEC63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080523163900.GD16137@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
Date: Tue, 27 May 2008 10:04:20 -0500
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163900.GD16137@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 11:39 AM, Anton Vorontsov wrote:

> This is needed to access QE GPIOs via Linux GPIO API.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-By: Timur Tabi <timur@freescale.com>
> ---
> Documentation/powerpc/booting-without-of.txt |   27 +++++
> arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
> arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
> arch/powerpc/sysdev/qe_lib/gpio.c            |  148 +++++++++++++++++ 
> +++++++++
> include/asm-powerpc/qe.h                     |    2 +
> 5 files changed, 187 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c

didn't we talk about putting this is drivers/gpio/ ?

- k
