Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 865D967A39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 22:26:47 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4JCVabx019510
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 15:31:37 +0300 (EEST)
Message-ID: <428C81E1.8020807@intracom.gr>
Date: Thu, 19 May 2005 15:09:05 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Bj=F6rn_=D6stby?= <Bjorn.Ostby@combitechsystems.com>
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CC0C@ratatosk.combitechsystems.com>
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CC0C@ratatosk.combitechsystems.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.6 and mpc823 compile error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Björn Östby wrote:
> Hi,
> I'm trying to get Linux 2.6.11 up and running on mpc823e. I'm using the cross compiler
> Supplied in ELDK (3.0) and u-boot. The problem is when enabling:
> 
> [ ] CPM SCC/SMC serial port support
> and/or
> [ ] CPM SCC Ethernet
> 
> The kernel compiles fine having these option disabled, but otherwise..see below
> 
> make arch=ppc CROSS_COMPILE=${CROSS_COMPILE}
> .
[snip]

> 
> 
> There it is. Any ideas? 
> 
> Regards,
> Bjorn Ostby
> 

Don't use this driver. Use the one in drivers/serial/cpm_uart.

Regards

Pantelis
