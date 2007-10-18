Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B357DE2AA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:20:59 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9IDKuch004309
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:20:56 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9IDKuXW549112
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:20:56 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9IDKf5a006261
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:20:41 +1000
Message-ID: <47175D9D.50802@linux.vnet.ibm.com>
Date: Thu, 18 Oct 2007 18:50:29 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.23-mm1 - powerpc - Build fails at arch/powerpc/boot/inflate.o
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	<47174C49.5050308@linux.vnet.ibm.com>
	<18199.20538.594159.877930@cargo.ozlabs.ibm.com>
In-Reply-To: <18199.20538.594159.877930@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, imsudhirkumar@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Kamalesh Babulal writes:
> 
>> The kernel build fails on the power box
>>
>>   INSTALL vdso64.so
>>
>>   INSTALL vdso32.so
>>
>>   BOOTCC  arch/powerpc/boot/inflate.o
>>
>> arch/powerpc/boot/inflate.c:920:19: error: errno.h: No such file or directory
> 
> This problem is fixed by d4faaecbcc6d9ea4f7c05f6de6af98e2336a4afb in
> Linus' tree.
> 
> Paul.
> -
Hi Paul,
Thanks, we tried it out over the 2.6.23-mm1 and the patch fixes the build failure.

-- 
Thanks & Regards,
Kamalesh Babulal,
