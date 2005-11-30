Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE51568850
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 18:11:54 +1100 (EST)
In-Reply-To: <438374FE.4040608@ntlworld.com>
References: <4382F0F2.4040807@ntlworld.com> <438374FE.4040608@ntlworld.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DA002B53-9333-4074-A507-754E5292A7F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 30 Nov 2005 01:11:51 -0600
To: Richard Danter <richard.danter@ntlworld.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Trying to understand initsenses and pci_irq_table
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 22, 2005, at 1:43 PM, Richard Danter wrote:

> Richard Danter wrote:
>> The kernel crashes after starting init. I see some random  
>> characters on the serial and then nothing. Looking in the log  
>> buffer via JTAG I can see that the init process exited with signal  
>> 11. I assume this is unrelated to the above, but any suggestions  
>> where I should look?
>
> I managed to fix this problem, so I am now booted and running  
> busybox from NFS :)
>
> I'd still like a pointer to any docs explaining the PCI and  
> interrupt stuff if possible.

Well the PCI SIG has specs.  If your talking about the code, its a  
simple lookup table.  The key is realizing that PCI_IRQ_TABLE_LOOKUP  
is a macro.

- kumar
