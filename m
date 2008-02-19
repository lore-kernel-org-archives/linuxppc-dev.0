Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB34BDE5AC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 07:19:29 +1100 (EST)
Message-Id: <25DD3C6B-0374-46E9-B5EC-035FA1B40182@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Marco Stornelli <marco.stornelli@coritel.it>
In-Reply-To: <47BB0ADE.60501@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: MPC8641D PCI-Express error
Date: Tue, 19 Feb 2008 14:19:17 -0600
References: <47BA9C13.6090400@coritel.it> <47BAE57E.9000806@freescale.com>
	<47BAF8FF.50608@coritel.it> <47BAFE6A.9050801@freescale.com>
	<47BB071E.4020204@coritel.it> <47BB0ADE.60501@freescale.com>
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 19, 2008, at 10:59 AM, Jon Loeliger wrote:

> Marco Stornelli wrote:
>
>> No, but I can try to backport the PCI-E code from 2.6.24 to 2.6.18  
>> if it
>> could help. What do you think about it? Do you think this problem  
>> could
>> be not present in 2.6.24?
>
> I have no idea there, honestly.  Sorry.

As Jon said, try 2.6.24 and see if it has an issue, if so we can look  
at helping.  if not, you know you need to back port the fixes.

- k
