Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8EDB5DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 03:06:29 +1100 (EST)
Message-ID: <47BAFE6A.9050801@freescale.com>
Date: Tue, 19 Feb 2008 10:06:02 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: MPC8641D PCI-Express error
References: <47BA9C13.6090400@coritel.it> <47BAE57E.9000806@freescale.com>
	<47BAF8FF.50608@coritel.it>
In-Reply-To: <47BAF8FF.50608@coritel.it>
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
> 
> Board: MPC8641D HPCN
> SoC: MPC8641D rev. 2

OK, this is good.

> Kernel: 2.6.18

And this is really old.  Any chance of up-rev'ing
that to something modern like 2.6.24?  You may find
that your PCI-E issues are Just Fixed there.  Dunno.

HTH,
jdl
