Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 33C45DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 02:38:54 +1100 (EST)
Message-ID: <47BAF8FF.50608@coritel.it>
Date: Tue, 19 Feb 2008 16:42:55 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: MPC8641D PCI-Express error
References: <47BA9C13.6090400@coritel.it> <47BAE57E.9000806@freescale.com>
In-Reply-To: <47BAE57E.9000806@freescale.com>
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
>> Hi,
>>
>> I'm working with the Freescale evaluation board MPC8641DHPCN and the
>> VIRTEX5 evaluation board ML555 connected with the PCI-Express. When I
>> try to read some register I have this problem:
>>
>> Machine check in kernel mode.
> 
> 
> Any chance you can tell us what rev anything is?
> SoC, Board, Kernel?
> 
> Significant improvement went into the 2.6.24 kernel
> development effort for many FSL PCI/PCI-E parts.
> 
> Thanks,
> jdl
> 

Board: MPC8641D HPCN
SoC: MPC8641D rev. 2
Kernel: 2.6.18

Thanks.

Marco
