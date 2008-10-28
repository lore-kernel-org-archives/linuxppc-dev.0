Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBBAFDDDE0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 03:13:25 +1100 (EST)
Message-ID: <490739FC.6020803@freescale.com>
Date: Tue, 28 Oct 2008 11:12:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mike Dyer <mike.dyer@provision-comm.com>
Subject: Re: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
References: <48F49D7D.5070107@provision-comm.com>	<48F4A8CD.6000101@provision-comm.com>	<22A97B63-36D5-44BA-8F49-BAF5870FA08A@kernel.crashing.org>	<1224065185.457.31.camel@mike-linux.provision-comm.com>
	<1225209233.937.6.camel@mike-linux.provision-comm.com>
In-Reply-To: <1225209233.937.6.camel@mike-linux.provision-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Dyer wrote:
> I believe the DMA is being added twice, because it occurs twice within the mpc8313erdb.dts device tree.  Once by itself, and once within a sleep-nexus.
> 
> Is that right / normal ?

No, that looks like a mismerge.  There should only be the node under 
sleep-nexus.

-Scott
