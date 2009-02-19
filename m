Return-Path: <pku.leo@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 880C5DDEFD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 18:19:49 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so99129yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 23:19:47 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
Date: Thu, 19 Feb 2009 15:19:45 +0800
Message-ID: <2a27d3730902182319i2c59d68dk98e7975714f80549@mail.gmail.com>
Subject: Re: Newby trying to get Ethernet going on MPC83xx series device.
From: Li Yang <leoli@freescale.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 19, 2009 at 2:58 PM, Dushara Jayasinghe
<DusharaJ@optiscan.com> wrote:
> That did it.
>
>
>
> I based my board specific file on mpc834x_itx.c which had
>
>
>
> static struct of_device_id __initdata mpc834x_itx_ids[] = {
>
>                 { .compatible = "fsl,pq2pro-localbus", },
>
>                 { .compatible = "simple-bus", },
>
>                 {},
>
> };
>
>
>
> Don't know if this is broken?

It's not broken as long as you have compatible = "simple-bus" for your soc node.

- Leo
