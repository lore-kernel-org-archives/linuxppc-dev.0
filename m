Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65F8467B9B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 18:12:49 +1000 (EST)
In-Reply-To: <20061020073745.GC17286@powerlinux.fr>
References: <20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<20061020072037.GA4355@aepfle.de>
	<20061020073745.GC17286@powerlinux.fr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D22CDFD1-C5A7-422E-9052-FFB5480AE06F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Date: Fri, 20 Oct 2006 10:12:40 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Sven Luther <sl@bplan-gmbh.de>, tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> cpuinfo is about the cpu, not the board layout nor the firmware
>> expectations.
>
> What is the machine: field doing there then ? Would it make sense  
> to provide a
> machineinfo then ?

Yes.  Or better, don't use /proc, get all info from sysfs
(with a nice userland tool to summarize the info, perhaps).


Segher
