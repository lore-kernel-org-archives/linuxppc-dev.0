Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC81D679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Mar 2006 01:54:05 +1100 (EST)
In-Reply-To: <200603241221.44576.carlos.mitidieri@sysgo.com>
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<AD260576-EB34-4B56-9FB7-CE3A2DAEBFE7@kernel.crashing.org>
	<200603241221.44576.carlos.mitidieri@sysgo.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <24661B8C-C4DF-4D9C-8F4A-F2E6600AFFE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: pci-x
Date: Fri, 24 Mar 2006 08:53:57 -0600
To: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
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


On Mar 24, 2006, at 5:21 AM, Carlos Mitidieri wrote:

>
> On Thursday 23 March 2006 16:41, Kumar Gala wrote:
>>> Is there PCI-X support for the mpc8540ads?
>>
>> Yes.  You have to make sure the board is setup (switches in the right
>> place) properly for it.
>
> Thank you for answering.
>
> Looking the manuals and schematics,  I have changed the "config"  
> switch in
> SW1, and now the PCI-X support is activated in the kernel at the  
> system
> initialization. Nevertheless,  when I plug a bridge board to the  
> slot 0, I
> get the following messages:
>
> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 1 of PCI bridge 1
> PCI: bridge 1 resource 1 moved to 9ff00000..9fffffff
> PCI: Cannot allocate resource region 2 of PCI bridge 1
> PCI: bridge 1 resource 2 moved to 9fe00000..9fefffff
>
> Would you guess that this is a driver problem, or that my board  
> setup is still
> incorrect?

That seems like a driver problem.  Does lspci show your devices after  
you boot?  Also, what kernel ver are you using?

- k
