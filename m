Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 454BA679EF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 00:19:23 +1000 (EST)
In-Reply-To: <428CF8D3.2070006@mrv.com>
References: <20050518170949.GA6766@gate.ebshome.net>
	<428CD40C.201@mrv.com>	<2376d87e3df664106a6cf626f9575d90@embeddededge.com>	<428CEA55.1040904@mrv.com>	<5e493590088edcf959e30390363e798d@embeddededge.com>
	<428CF693.5030100@mrv.com> <428CF8D3.2070006@mrv.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f751960e7a7299d7f28c54b53417ac57@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 20 May 2005 10:19:28 -0400
To: Guillaume Autran <gautran@mrv.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix cpm_uart_int() missing interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 19, 2005, at 4:36 PM, Guillaume Autran wrote:

>  One thought though, if the event register is cleared _before_=A0 the=20=

> event is processed (clearing the cause),

The cause of the event is it set completion flags on the buffer=20
descriptors.

>  will the cpm set the bit again (before we have time to clear the=20
> cause) ? That would generate 2 interrupts for the same event ? Am I=20
> right ?

No, it will work fine.

Thanks.


	-- Dan
