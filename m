Return-Path: <enno.luebbers@upb.de>
Received: from mail.uni-paderborn.de (mail.uni-paderborn.de [131.234.142.9])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6F84DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 18:24:30 +1100 (EST)
Received: from p4fc4beea.dip.t-dialin.net ([79.196.190.234] helo=[10.10.3.100])
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63 omicron-persei-viii) id 1JEg9p-0008AV-7d
	for linuxppc-embedded@ozlabs.org; Tue, 15 Jan 2008 08:24:25 +0100
Message-Id: <25E6571A-2B11-44AB-82D8-02EC15CEC35E@upb.de>
From: =?ISO-8859-1?Q?Enno_L=FCbbers?= <enno.luebbers@upb.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <440abda90801141614u777edfbndc5d2c61f927dd4f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Problem booting Linux 2.6 on Virtex-4
Date: Tue, 15 Jan 2008 08:24:23 +0100
References: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com>
	<62D97388-4D65-4B40-A0D1-847963FF0A16@upb.de>
	<440abda90801141211m52bd0a3bk67014c6df2bf406c@mail.gmail.com>
	<20080114210954.AC436CF8050@mail36-dub.bigfish.com>
	<440abda90801141614u777edfbndc5d2c61f927dd4f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

Am 15.01.2008 um 01:14 schrieb David Baird:

> Today, I tried a completely fresh design in EDK 9.2i (whereas I had
> been using 9.1i).  I tried the design found in
> EDKexamples/Virtex4_PPC_Example_9_2.zip.  This design works :-)  I am
> not sure why it works (or rather, why the other one did not work), but
> it works.

I'm using EDK 9.1i  with the reference design from the Xilinx website (www.xilinx.com/ml403) 
. This one is using a PLB BRAM controller for the bootup code section,  
not an OCM BRAM. Maybe there's something wrong with the OCM  
controller? Though OCM is not cached at all...

Anyway, glad it worked out.

Regards
- Enno

-- 
Dipl.-Ing. Enno Luebbers
Computer Engineering Group
University of Paderborn	

Warburger Str. 100		
33098 Paderborn			

http://wwwcs.upb.de/cs/ag-platzner
phone:  05251 / 60-5397
fax:    05251 / 60-5377
