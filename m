Return-Path: <enno.luebbers@upb.de>
Received: from mail.uni-paderborn.de (mail.uni-paderborn.de [131.234.142.9])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AED1BDE04D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 23:46:50 +1100 (EST)
Received: from nb-techinf-4.cs.uni-paderborn.de ([131.234.20.215])
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.62 cyclopia) id 1JDIFf-0000bk-Bt
	for linuxppc-embedded@ozlabs.org; Fri, 11 Jan 2008 12:40:43 +0100
Message-Id: <8CD31E85-5490-4E42-B91F-1217A415B214@upb.de>
From: =?ISO-8859-1?Q?Enno_L=FCbbers?= <enno.luebbers@upb.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Linux for ml310
Date: Fri, 11 Jan 2008 12:40:43 +0100
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Joachim,

I haven't tried the XUP or the ML310 yet, but I just managed to get  
Linux 2.4.26 from Bitkeeper running on a ML403 board (a Virtex-4FX12).  
However, I'm seriously considering moving to the 2.6 kernel, for  
various reasons.

Your problems seem to be related to the BSP configuration. Have you  
set the corerct options in the Software Platform Settings of the EDK?  
In particular, you need to set the clock frequency and the attached  
peripherals in the "OS and Libraries" section.

Regards
- Enno

-- 
Dipl.-Ing. Enno Luebbers
Computer Science Department
University of Paderborn	

Warburger Str. 100		
33098 Paderborn			

http://wwwcs.upb.de/cs/ag-platzner
phone:  05251 / 60-5397
fax:    05251 / 60-5377
