Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86069DDFC4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:22:32 +1000 (EST)
Message-ID: <4673030F.5040703@freescale.com>
Date: Fri, 15 Jun 2007 16:22:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: for-2.6.23 branch in powerpc.git created
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0706151915580.5979@poirot.grange>
	<4672D694.5060701@freescale.com>
	<Pine.LNX.4.60.0706152016150.5979@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0706152016150.5979@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> On Fri, 15 Jun 2007, Scott Wood wrote:
>>I'd leave out the device_type, and the "rtc" in "rtc-r5c372" is redundant if
> 
> No, it is not redundant, it has to match rs5c372_driver.driver.name.

Sorry, I meant if you had control over what the driver calls itself... 
I'd misread the name, and thus my grep failed, so I assumed it was a new 
driver.

-Scott
