Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56334DDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 04:25:12 +1000 (EST)
Date: Tue, 15 May 2007 13:20:38 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] powerpc: add dts entries to 85xx for EDAC
In-Reply-To: <20070510170305.GA16203@blade.az.mvista.com>
Message-ID: <Pine.LNX.4.64.0705151320210.14194@localhost.localdomain>
References: <20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
	<3EF891D2-F973-43D6-B43B-B8BBC4269C60@kernel.crashing.org>
	<4640AE88.9040806@mvista.com>
	<6fb05a0954f19c5744369c18670d81ff@kernel.crashing.org>
	<20070509165333.GA3118@blade.az.mvista.com>
	<3E2DA6EA-8952-47B3-A395-C416D7AC9D62@kernel.crashing.org>
	<20070510170305.GA16203@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007, Dave Jiang wrote:

> Adding memory-controller and l2-cache-controller entries to be used by EDAC
> as of_devices.
>
> Signed-off-by: Dave Jiang <djiang@mvista.com>
>
> ---
>
> Fixed up additional changes per Kumar.
>
>  arch/powerpc/boot/dts/mpc8540ads.dts |   16 ++++++++++++++++
>  arch/powerpc/boot/dts/mpc8548cds.dts |   16 ++++++++++++++++
>  arch/powerpc/boot/dts/mpc8560ads.dts |   18 +++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletions(-)

applied.

- k
