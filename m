Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2042EDDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 06:50:08 +1100 (EST)
Message-ID: <47545E47.8010408@ovro.caltech.edu>
Date: Mon, 03 Dec 2007 11:51:35 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Maximum ioremap size for ppc arch?
References: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
	<20071203153009.GA30746@gate.crashing.org>
	<475441DD.9030601@ovro.caltech.edu>
	<20071203190723.GB30746@gate.crashing.org>
In-Reply-To: <20071203190723.GB30746@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

> Yes, same thing. There's N ways to fix it. But I see you're talking
> x86.
> 
>> PS. The CPUs in this case are x86 based, while the PCI boards use
>> PLX-9054 bridges. I'm building new peripheral boards with MPC8349EAs
>> so this problem is going to rear its ugly head again soon, when
>> I work on the drivers for the new peripheral boards.
> 
> You should be able to do something similar on x86 but the details
> are TBD. I would probably try to limit low memory to 512MB in the
> x86 case.

Yeah, that works for me. The CPUs were ordered with 512MB,
but arrived with 1GB. It was thought a windfall at the time ...
but not-so after the driver weirdness :)

Thanks for the info. Now at least if I want to understand the
problem, I know where to look.

Cheers,
Dave
