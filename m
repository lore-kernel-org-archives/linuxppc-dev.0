Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 754A6DDF9E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:13:08 +1000 (EST)
Message-Id: <C907A431-5D03-4614-9D84-67BDA061B01D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090502021649.GB18281@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/6] powerpc/85xx: Fix mpc8569emds' crypto node to include
	SNOW unit
Date: Fri, 8 May 2009 09:11:02 -0500
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
	<20090502021649.GB18281@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 9:16 PM, Anton Vorontsov wrote:

> fsl,exec-units-mask should be 0xbfe to include SNOW unit in
> MPC8569E's security engine.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
