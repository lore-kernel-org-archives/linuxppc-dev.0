Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6923BB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 04:06:59 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p6CHjteY012430
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 13:45:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6CI6sKW114042
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 14:06:55 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p6CC3h5i008937
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 06:03:44 -0600
Date: Tue, 12 Jul 2011 14:04:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ayman El-Khashab <ayman@elkhashab.com>
Subject: Re: [PATCH] 4xx: Add check_link to struct ppc4xx_pciex_hwops
Message-ID: <20110712180404.GC4203@zod.rchland.ibm.com>
References: <20110701064424.GE13483@ozlabs.org>
	<20110712174007.GA26664@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110712174007.GA26664@crust.elkhashab.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2011 at 12:40:07PM -0500, Ayman El-Khashab wrote:
>On Fri, Jul 01, 2011 at 04:44:24PM +1000, Tony Breeds wrote:
>> All current pcie controllers unconditionally use SDR to check the link and
>> poll for reset.
>
>I was able to apply this patch and then modify the 460SX to
>work correctly, so I think it is fine.  There is only 1
>comment below.  So how does one supply a patch atop another
>patch?
>
>Best,
>Ayman
>
>> +static int __init ppc4xx_pciex_port_reset_sdr(struct ppc4xx_pciex_port *port)
>> +{
>> +	printk(KERN_INFO "PCIE%d: Checking link...\n",
>> +	       port->index);
>
>Its not a functional problem, but this printk belongs in the
>check link if anywhere rather than the reset.

I've got this queued in my tree locally.  I can make that change before
I push it out.

josh
