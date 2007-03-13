Return-Path: <pochini@denise.shiny.it>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3ACA8DDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:54:12 +1100 (EST)
Date: Tue, 13 Mar 2007 10:53:50 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
In-Reply-To: <je6496asea.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.64.0703131050430.8516@denise.shiny.it>
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
	<je6496asea.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 13 Mar 2007, Andreas Schwab wrote:

> Giuliano Pochini <pochini@denise.shiny.it> writes:
>
>> I had a look at arch/powerpc/kernel/smp.c but I'm not familiar at all with
>> those parts of the kernel.
>
> See arch/powerpc/kernel/sysfs.c:topology_init.  I don't think there is
> anything to do here.  You probably don't have CONFIG_HOTPLUG_CPU enabled.

I can't check it out right now, but I'm sure it is enabled as I wrote in 
my first message. I said arch/powerpc/kernel/smp.c because the respective 
file in arch/s390 was fixed recently for the same issue.


--
Giuliano.
