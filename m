Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34692DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 01:33:58 +1100 (EST)
In-Reply-To: <000801c7460d$211e46e0$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
	<1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
	<000301c7458b$b9eb1330$6405a8c0@absolut>
	<829261C6-F534-4B85-A04D-8D280E46B2CF@kernel.crashing.org>
	<000401c74591$8a3a4ec0$6405a8c0@absolut>
	<BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
	<000801c7460d$211e46e0$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <974C77BD-19A0-4843-8E7B-3B430DB4ADE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8360E - PCI / DTC Blob Setup
Date: Thu, 1 Feb 2007 08:33:00 -0600
To: rmcguire@videopresence.com
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


On Feb 1, 2007, at 8:27 AM, Russell McGuire wrote:

> Since I am hip deep in debugging the PCI system.
>
> In the .dts files there is the section for the PCI setup.
>
> The interrupt-map = < >
>
> Does this need to include:
> 1) A mapping for every IDSEL line in the system?
> 2) Only those IDSELs that are used on the slots on the motherboard?

I'm not sure I follow the difference between 1/2. The map needs to  
cover every IDSEL that has an IRQ line wired to it.

> 3) A custom entry for every card we want to support?

See above.

> 4) How does a bridge chip and slave busses affect the entries, if  
> at all?

Uugh, I'm not sure how bridges are handled at this point.

> Looking at the mpc8360 / 8349 setups that are part of the latest  
> kernel
> trees, some are place many and some are placing just a single entry?
>
> Which should be the preferred method?

It depends on your HW setup, the 8360/49 boards have some 'odd' IDSEL  
irq mapping.

- k
