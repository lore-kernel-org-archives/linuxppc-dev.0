Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62D3167F0E
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:21:21 +1100 (EST)
Subject: Re: [PATCH 3/5] [POWERPC] 8xx: platform-related changes to the
	fsl_soc.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20061114012819.17455.53319.stgit@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012819.17455.53319.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 13:21:14 +1100
Message-Id: <1163470874.5940.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-14 at 04:28 +0300, Vitaly Bordug wrote:
> Added 8xx SoC peripherials: fec for Ethernet and smc for UARTs.
> Ordinary routines to extract values from the device tree and insert respective
> platform devices

Note that imho, that's at best a temporary thing. It would be much
better to have these drivers register as of_platform_driver's and have
the platform code publish of_platform_device's for all SoC nodes.

Ben.
