Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FA1FDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 02:59:52 +1100 (EST)
Message-ID: <478B86E5.6060605@freescale.com>
Date: Mon, 14 Jan 2008 09:59:33 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: mike zheng <mail4mz@gmail.com>
Subject: Re: Quick Engine Support on Kernel 2.4
References: <5c9cd53b0801111521v25d0c1dt21ee59373826298@mail.gmail.com>
In-Reply-To: <5c9cd53b0801111521v25d0c1dt21ee59373826298@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mike zheng wrote:

> Is there any BSP on Linux Kernel 2.4 support Quick Engine of MPC8568?
> If not, which BSP shall I start the porting? The BSP(on Kernel2.6) of
> MPC8568MDS from Freescale supports CPM2, but not QE. What the
> difference between CPM2 and QE?

Think of the QE as CPM3.

"Supporting the QE" means many things.  The 2.6 kernel has core support for the 
QE as well as support for several QE devices.  You'll need to be more specific.

-- 
Timur Tabi
Linux kernel developer at Freescale
