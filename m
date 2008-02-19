Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id C7410DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 03:39:12 +1100 (EST)
Message-ID: <47BB071E.4020204@coritel.it>
Date: Tue, 19 Feb 2008 17:43:10 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: MPC8641D PCI-Express error
References: <47BA9C13.6090400@coritel.it> <47BAE57E.9000806@freescale.com>
	<47BAF8FF.50608@coritel.it> <47BAFE6A.9050801@freescale.com>
In-Reply-To: <47BAFE6A.9050801@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Jon Loeliger ha scritto:
> Marco Stornelli wrote:
>>
>> Board: MPC8641D HPCN
>> SoC: MPC8641D rev. 2
> 
> OK, this is good.
> 
>> Kernel: 2.6.18
> 
> And this is really old.  Any chance of up-rev'ing
> that to something modern like 2.6.24?  You may find
> that your PCI-E issues are Just Fixed there.  Dunno.
> 
> HTH,
> jdl
> 

No, but I can try to backport the PCI-E code from 2.6.24 to 2.6.18 if it
could help. What do you think about it? Do you think this problem could
be not present in 2.6.24?
