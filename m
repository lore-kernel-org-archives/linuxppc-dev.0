Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 44A8DDDFB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 00:27:04 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K8FfZ-0007Sg-3B
	for linuxppc-embedded@ozlabs.org; Mon, 16 Jun 2008 14:26:53 +0000
Received: from fw-emea.rohde-schwarz.com ([80.246.32.33])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 Jun 2008 14:26:53 +0000
Received: from euphoria by fw-emea.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 Jun 2008 14:26:53 +0000
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: Reserving small amounts of memory with mem= (MPC85xx,   2.6.15
	arch/ppc)
Date: Mon, 16 Jun 2008 16:26:43 +0200
Message-ID: <g35t76$u50$1@ger.gmane.org>
References: <g2ri8j$qlk$1@ger.gmane.org>	<d194b8ce0806121214w2ac2edf6n7f222eb51463a989@mail.gmail.com>	<g2u0ae$238$1@ger.gmane.org>
	<485292C2.6030103@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <485292C2.6030103@freescale.com>
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> CAM entries can be any power of 4 between 4K and 256M.  However, the 
> code currently is hardcoded to use no more than 3 entries.

Ah, this explains a lot, thanks.

> Alternately, do you have highmem enabled?  That will let you access the 
> rest of the RAM that the CAM doesn't map, though I don't know if an 
> initrd in highmem works.

I didn't had highmem enabled so far. Now it is and Linux is able to 
allocate rest of memory.

It doesn't work if initrd is placed in highmem though. I just put it at 
the end of lowmem.

Cheers,

   Florian
