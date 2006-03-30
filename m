Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C145067A5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 03:28:53 +1100 (EST)
In-Reply-To: <200603281651.53196.carlos.mitidieri@sysgo.com>
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<24661B8C-C4DF-4D9C-8F4A-F2E6600AFFE2@kernel.crashing.org>
	<200603241607.35267.carlos.mitidieri@sysgo.com>
	<200603281651.53196.carlos.mitidieri@sysgo.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <621AE6AC-D37E-4EB5-9390-7050B654C692@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: pci-x
Date: Thu, 30 Mar 2006 10:28:59 -0600
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


On Mar 28, 2006, at 08:51, Carlos Mitidieri wrote:

>
>> On Friday 24 March 2006 15:53, Kumar Gala wrote:
>>> That seems like a driver problem.  Does lspci show your devices  
>>> after
>>> you boot?  Also, what kernel ver are you using?
>>
>> No, the device behind the bridge is not recognized, although the  
>> bridge
>> itself is. I am using kernel 2.6.15.
>
> I am trying to use a PCI-X bridge (Intel 31154) on a mpc8540ads  
> running kernel
> 2.6.15.  A USB controller is behind the bridge.
>
> When the mpc8540ads is booted with the PCI-X switch disabled, the  
> device
> behind the bridge is detected (and actually works), and the following
> messages are printed:

Are you using a Rev A or higher board?  PCI-X doesn't work on earlier  
systems.

Also, make sure your board is configured to run PCI at 66 MHz.  PCI-X  
doesn't work at 33 MHz.


Andy Fleming
