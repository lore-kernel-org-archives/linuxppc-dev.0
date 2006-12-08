Return-Path: <schihei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2A9767BB3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 21:24:12 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kB8AO7Yw164550
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 10:24:07 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kB8AO76d2105402
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 10:24:07 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kB8AO7eT002871
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 10:24:07 GMT
Message-ID: <45793D48.2070808@de.ibm.com>
Date: Fri, 08 Dec 2006 11:24:08 +0100
From: Heiko Joerg Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 1/1] ipmi: add autosensing of ipmi device on powerpc	using
	device-tree
References: <20061207172259.64168f8c@localhost>
	<20061207172445.2108cf43@localhost>
In-Reply-To: <20061207172445.2108cf43@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Krafft wrote:
> This patch adds support for of_platform_driver to the ipmi_si module.
> When loading the module, the driver will be registered to of_platform.
> The driver will be probed for all devices with the type ipmi. It's supporting
> devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
> Only ipmi-kcs could be tested.
>
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
>   
Acked-by: Heiko J Schick <schihei@de.ibm.com>

Regards,
    Heiko
