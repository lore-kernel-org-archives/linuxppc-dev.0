Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EC39EDDEBC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 20:42:29 +1100 (EST)
Date: Tue, 6 Mar 2007 12:42:18 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [patch 1/1] ppc: Possible bug fix for FCC driver
Message-ID: <20070306124218.4bebc288@localhost.localdomain>
In-Reply-To: <989B956029373F45A0B8AF02970818902DA97B@zch01exm26.fsl.freescale.net>
References: <00B1F4365DDBE745B091C67A1CCFCB43070CE21E@zctfhxm1>
	<989B956029373F45A0B8AF02970818902DA97B@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dmalek@jlc.net, linuxppc-embedded@ozlabs.org,
	Cedric Pontois <cpontois@nortel.com>, linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2007 10:23:43 +0800
Li Yang-r58472 wrote:

> Hi Cedric,
> 
> For ppc embedded related patches, please also cc:
> linuxppc-embedded@ozlabs.org.
> 
> > We use a kernel 2.6.14 on PPC platform (MPC 8555). The FCC driver
> works
> 
> To submit a kernel patch upstream, the patch should be against the
> latest kernel version which is 2.6.21-rc now.
> > well with a 100Mbps link. But it doesn't with a 10Mbps link. To
> > solve it, I modified the GFMR register init: removed TCI bit and
> > set CRC32
> bit
> > instead of.
> 
> I don't know how these bits caused the 10M link issue.  Do you have
> any reasoning?
> 
> > 	Signed-off-by: Cedric Pontois <cpontois@nortel.com>
> > 
> >
> ------------------------------------------------------------------------
> > -----
> > 
> > diff -ruN pa-original/arch/ppc/8260_io/fcc_enet.c
The fcc code in 8260_io has been obsoleted by fs_enet driver (drivers/net/fs_enet).
It is known to work with 85xx at least in recent kernels. If it does not for some reason,
please letus know.

Thanks,

-Vitaly
