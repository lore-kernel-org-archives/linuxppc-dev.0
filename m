Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 561EC1011AD
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:11:40 +1100 (EST)
Subject: Re: [PATCH 4/7] powerpc/85xx/86xx: Add suspend/resume support
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090915214357.GD24821@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 08:11:35 -0600
Message-Id: <A0266665-01A9-4AB4-94CB-584F4A92085A@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214357.GD24821@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2009, at 4:43 PM, Anton Vorontsov wrote:

> This patch adds suspend/resume support for MPC8540 and MPC8641D-
> compatible CPUs. To reach sleep state, we just write the SLP bit
> into the PM control and status register.
>
> So far we don't support Deep Sleep mode as found in newer MPC85xx
> CPUs (i.e. MPC8536). It can be relatively easy implemented though,
> and for it we reserve 'mem' suspend type.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/Kconfig          |   11 +++++-
> arch/powerpc/sysdev/Makefile  |    1 +
> arch/powerpc/sysdev/fsl_pmc.c |   88 ++++++++++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 99 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_pmc.c

applied to next

- k
