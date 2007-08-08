Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14C81DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 02:49:35 +1000 (EST)
Message-ID: <46B9F419.7060202@freescale.com>
Date: Wed, 08 Aug 2007 11:49:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: how the bytes ordered in mpc8313
References: <CE785D12544843B49C5D1315CAE61C23.MAI@mail.livedns.co.il>
In-Reply-To: <CE785D12544843B49C5D1315CAE61C23.MAI@mail.livedns.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yoni Levin wrote:
> I have mpc83xx,
> 
> I saw that I need to use swab32 to any read\write operation from registers,

Only little endian registers (such as PCI).

> Why in the mpc8313 reference in registers description some bits look like
> 31,30,29,.,3,2,1,0
> 
> And some: 0,1,2,3.,30,31

Most PowerPC documentation numbers bits in the same endianness as the 
bytes in the register.

> Is it just mistake? Or some registers are different then other? 

I consider big-endian bit numbering to be a mistake, but good luck 
getting them to fix it. :-)

-Scott
