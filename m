Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id CA4B6DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 05:39:06 +1100 (EST)
In-Reply-To: <478F92EB.2000500@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Endian problem when accessing internel regs on 8347
MIME-Version: 1.0
Message-ID: <OF828247BA.CFEBC1F6-ON882573D3.00661B7D-882573D3.00666F62@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 17 Jan 2008 10:38:53 -0800
Content-Type: text/plain; charset="US-ASCII"
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

> > __asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" : "=r" (ret) 
: 
> > "m" (*addr));
> 
> They allow the compiler to use update and/or index mode for the memory 
> operand.

Well that makes sense, U for update and X for index, but I'm not sure 
they're applicable to this particular instruction and I'm not sure that 
the memory operand makes sense for PowerPC.  However, before I post 
anything that makes me look like I've got hoof-n-mouth disease I'm going 
to do some more digging.  Is the GCC manual the only "official" 
documentation on this (I've found a couple of web sites but none of them 
gun.org) or is there another manual I should be looking for?

Thanks for the pointers.

Bruce
