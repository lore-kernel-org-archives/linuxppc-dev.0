Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D266DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 07:53:11 +1000 (EST)
Message-ID: <4858322C.5030402@freescale.com>
Date: Tue, 17 Jun 2008 16:52:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: PCI DMA Problems With 82xx?
References: <4858113F.4050203@vecimanetworks.com>
	<48582CC6.60004@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B048F2E21@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B048F2E21@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mike Winter <mike.winter@vecimanetworks.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> linuxppc-embedded-bounces+runet=innovsys.com@ozlabs.org wrote:
>> Mike Winter wrote:
>>> We are developing with an 8248-based platform, and we have a vendor
>>> telling us that the PCI hardware is unreliable on this CPU family, in
>>> particular the DMA functionality.  A quick search of this list
>>> doesn't turn up any horror stories, although the processor does have
>>> some PCI errata listed.  Does anybody have any practical experience
>>> using PCI on the 8248 or similar that they can share with me?  
>>> Thanks. 
> 
> We're using all four PCI DMA's on 8265 and 8280 CPU's.

Hmm, did he mean bus-mastering from PCI devices, or the DMA block which 
is documented as part of PCI on older chips, but really has nothing to 
do with it that I can figure out?

-Scott
