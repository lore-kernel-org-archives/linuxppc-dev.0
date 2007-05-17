Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DD2DDDEB9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:14:34 +1000 (EST)
In-Reply-To: <1179417813.8132.250.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
Date: Thu, 17 May 2007 11:14:07 -0500
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2007, at 11:03 AM, Wade Farnsworth wrote:

> On Thu, 2007-05-17 at 10:50 +0800, Zhang Wei-r63237 wrote:
>> Hi,
>>
>> If you add below sector to pci@8000, please remove the interrupt-map
>> sector from pci@8000.
>
> Correct me if I'm wrong, but I think if the interrupt-map for pci@8000
> is removed then the pci devices on the revision 1.0 board will not get
> the correct interrupts.  I don't currently have a rev 1.0 to test
> though.  Can someone with a rev 1.0 HPCN board confirm this?

If I'm understanding things this might best be handled by two  
different dts.  Is this because of board changes or chip/silicon  
changes?

- k
