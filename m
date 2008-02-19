Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35E90DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 01:19:51 +1100 (EST)
Message-ID: <47BAE57E.9000806@freescale.com>
Date: Tue, 19 Feb 2008 08:19:42 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: MPC8641D PCI-Express error
References: <47BA9C13.6090400@coritel.it>
In-Reply-To: <47BA9C13.6090400@coritel.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Marco Stornelli wrote:
> Hi,
> 
> I'm working with the Freescale evaluation board MPC8641DHPCN and the
> VIRTEX5 evaluation board ML555 connected with the PCI-Express. When I
> try to read some register I have this problem:
> 
> Machine check in kernel mode.


Any chance you can tell us what rev anything is?
SoC, Board, Kernel?

Significant improvement went into the 2.6.24 kernel
development effort for many FSL PCI/PCI-E parts.

Thanks,
jdl
