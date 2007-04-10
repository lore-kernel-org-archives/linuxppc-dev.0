Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E100DDF48
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 02:48:59 +1000 (EST)
Message-ID: <461BBFF5.2000200@freescale.com>
Date: Tue, 10 Apr 2007 11:48:53 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: MPC 8349e-mITX and MTD/Flash
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>	<CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>	<461BB1DB.9050503@freescale.com>
	<CF7E46FCFF66AD478BB72724345289EC2795D3@twx-exch01.twacs.local>
	<461BBFD5.7030302@ru.mvista.com>
In-Reply-To: <461BBFD5.7030302@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Benedict, Michael" <MBenedict@twacs.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Hello.
> 
> Benedict, Michael wrote:
> 
>>> Having said that, it seems that the kernel now supports defining the 
>>> physmap via the OF tree.  Is that true?
> 
>> Initially I was going to try and define this via the OF tree.  However,
>> the documentation indicated that the only supported device_type was
>> "rom" so I did not persue that route.
> 
>   There was long discussion about using "mtd" and other types -- people 
> were complaining that "mtd" was too Linux-centric term, so finally we 
> ended up with "rom".  It doesn't imply that ROMs are the only supported 
> devices. :-)

Okee dokee.  I'll add it to my to-do list.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
