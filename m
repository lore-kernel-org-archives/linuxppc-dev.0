Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBD5EDE17E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:15:20 +1000 (EST)
Message-Id: <CC7DA92D-EE00-48E9-AAA0-51A13A3BD5D0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080519174705.GD28185@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
Date: Tue, 10 Jun 2008 11:15:08 -0500
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174705.GD28185@polina.dev.rtsoft.ru>
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


On May 19, 2008, at 12:47 PM, Anton Vorontsov wrote:

> This is needed to access QE GPIOs via Linux GPIO API.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-By: Timur Tabi <timur@freescale.com>
> ---
> Documentation/powerpc/booting-without-of.txt |   27 +++++
> arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
> arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
> arch/powerpc/sysdev/qe_lib/gpio.c            |  146 +++++++++++++++++ 
> +++++++++
> include/asm-powerpc/qe.h                     |    3 +
> 5 files changed, 186 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c

applied.

- k
