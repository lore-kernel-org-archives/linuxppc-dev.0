Return-Path: <tnt@246tNt.com>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.5.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 909C9DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 18:07:18 +1100 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l09775l6008528
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 08:07:06 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A33E93.9060908@246tNt.com>
Date: Tue, 09 Jan 2007 08:04:51 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>	
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>	
	<1168303139.22458.246.camel@localhost.localdomain>	
	<20070109005624.GA598@suse.de>	
	<1168308323.22458.254.camel@localhost.localdomain>
	<1168326274.14763.313.camel@shinybook.infradead.org>
In-Reply-To: <1168326274.14763.313.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <gregkh@suse.de>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> On Tue, 2007-01-09 at 13:05 +1100, Benjamin Herrenschmidt wrote:
>   
>> Sylvain fixes are. My endian patches are for ps3 and toshiba celleb,
>> none of which is fully merged in 2.6.20 so they are fine to wait. It's
>> mostly a matter of being a PITA to rebase Sylvain stuff to apply before
>> mine and rebase mine on top of his I suppose :-) 
>>     
>
> Er, doesn't Efika need the same endian patches?
>   
No, Ben's patches are for controller that have registers in big-endian and
memory structures in little-endian.

52xx is full big-endian and that's already supported since quite some time
now.


    Sylvain
