Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35DDA688B8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 01:28:25 +1100 (EST)
In-Reply-To: <439D120E.9010606@rftechnology.com.au>
References: <439CE3A2.8020603@rftechnology.com.au>
	<dc0620490d9bef30d3a4b629483cd3f9@embeddededge.com>
	<439D120E.9010606@rftechnology.com.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE8B4925-AF71-46D6-B542-A86FBFDC6E65@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 12 Dec 2005 08:28:26 -0600
To: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 82xx IRQ handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 12, 2005, at 12:00 AM, Dmytro Bablinyuk wrote:

>>> immap->im_intctl.ic_simrh &= ~(0x0800);
>> You should not be messing around with this register
>> in your code.  The generic 82xx interrupt functions
>> will properly manage this for you.
> Thank you Dan,
> It's working now!
>
> By the way question - shall I program somewhere an edge of the IRQ  
> or it always triggers on the rising edge?
>
> Also does anybody knows any source code example of using 82xx  
> General Purpose Timer Unit so that it triggers interrupt handler  
> after some period.

The IRQ pins are set to edge trigger by default.

- kumar
