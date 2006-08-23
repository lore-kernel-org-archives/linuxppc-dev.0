Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF58567C0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 09:06:32 +1000 (EST)
In-Reply-To: <3C02138692C13C4BB675FE7EA240952918DFB7@bluefin.Soneticom.local>
References: <3C02138692C13C4BB675FE7EA240952918DFB7@bluefin.Soneticom.local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <09339AC2-6F79-4261-92B8-3068A4B33876@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI resource allocation MPC8540ADS
Date: Wed, 23 Aug 2006 18:06:26 -0500
To: Clint Thomas <cthomas@Soneticom.com>
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


On Aug 23, 2006, at 4:11 PM, Clint Thomas wrote:

> Hey guys,
>
> I have a development board based loosely off the MPC8540ADS design  
> that I am trying to move to the Linux kernel 2.6. I already have  
> this system working successfully in Linux Kernel 2.4, but after  
> dealing with compilation and load errors, i've come to the point  
> where I can get to a console. However, this problem at boot time  
> keeps me from using a lot of onboard hardware. When I enable PCI  
> support in the Kernel configuration, this is the text I get at boot  
> time...

which 2.6 kernel are you using?

> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 1 of PCI bridge 1
> PCI: Cannot allocate resource region 2 of PCI bridge 1
> PCI: bridge 1 resource 2 moved to 9ff00000..9fffffff
> PCI: Cannot allocate resource region 1 of PCI bridge 2
> PCI: Cannot allocate resource region 2 of PCI bridge 2
> PCI: bridge 2 resource 2 moved to 9fe00000..9fefffff
> PCI: Cannot allocate resource region 1 of device 0000:00:14.0
> PCI: Cannot allocate resource region 2 of device 0000:00:14.0
> PCI: Cannot allocate resource region 0 of device 0000:01:01.0
> PCI: Cannot allocate resource region 1 of device 0000:01:01.0
> PCI: Cannot allocate resource region 2 of device 0000:01:01.0
> PCI: Cannot allocate resource region 0 of device 0000:01:05.0
> PCI: Cannot allocate resource region 1 of device 0000:01:05.0
> PCI: Cannot allocate resource region 2 of device 0000:01:05.0
> PCI: Cannot allocate resource region 0 of device 0000:01:06.0
> PCI: Cannot allocate resource region 0 of device 0000:01:06.1
> PCI: Cannot allocate resource region 0 of device 0000:01:06.2
> PCI: Failed to allocate mem resource #0:1000000@0 for 0000:01:01.0
> PCI: Failed to allocate I/O resource #1:100@1000 for 0000:01:01.0
> PCI: Failed to allocate mem resource #2:1000@0 for 0000:01:01.0
> PCI: Failed to allocate mem resource #0:10000@0 for 0000:01:05.0
> PCI: Failed to allocate mem resource #2:10000@0 for 0000:01:05.0
> PCI: Failed to allocate mem resource #0:1000@0 for 0000:01:06.0
> PCI: Failed to allocate mem resource #0:1000@0 for 0000:01:06.1
> PCI: Failed to allocate mem resource #0:100@0 for 0000:01:06.2
>
> the system is using a PLX PCI bridge chip. Like I said, this works  
> fine in my 2.4 distribution. Thanks for any and all help!

can you post an lspci -v output.

- kumar
