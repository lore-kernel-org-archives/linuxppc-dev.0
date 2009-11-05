Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41FE6B7B94
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:15:56 +1100 (EST)
Subject: Re: [PATCH 2/7] powerpc/qe: QE also shuts down on MPC8568
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090915214354.GB24821@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:15:49 -0600
Message-Id: <98358BC3-7A8A-445D-BB82-0D2049AA5D47@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214354.GB24821@oksana.dev.rtsoft.ru>
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

> It appears that QE shuts down on all MPC85xx CPUs (i.e. MPC8568 and
> MPC8569) and thus needs reset upon resume.
>
> So modify qe_alive_during_sleep() to account that.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/qe.h   |   23 ++++++++++++++++++++++-
> arch/powerpc/sysdev/qe_lib/qe.c |   13 -------------
> 2 files changed, 22 insertions(+), 14 deletions(-)

applied to next.

- k
