Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75695DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 05:00:30 +1100 (EST)
Message-ID: <478F92EB.2000500@freescale.com>
Date: Thu, 17 Jan 2008 11:39:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Endian problem when accessing internel regs on 8347
References: <OF03A8BF8B.4AC46CCD-ON882573D3.00216F5B-882573D3.00236B8D@selinc.com>
In-Reply-To: <OF03A8BF8B.4AC46CCD-ON882573D3.00216F5B-882573D3.00236B8D@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Bruce_Leonard@selinc.com wrote:
> As an additional question related to PowerPC inline assembly, can anyone 
> tell me what "%U1%X1" means in the following:
> 
> __asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" : "=r" (ret) : 
> "m" (*addr));

They allow the compiler to use update and/or index mode for the memory 
operand.

-Scott
