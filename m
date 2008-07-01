Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6A5CDE252
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 18:04:20 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6183RhM017271
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 18:03:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6184IOM161460
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 18:04:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6184Ipx013915
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 18:04:18 +1000
Message-ID: <4869E4FF.8030202@linux.vnet.ibm.com>
Date: Tue, 01 Jul 2008 13:34:15 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [BUILD-FAILURE] linux-next: Tree for June 30 - powerpc - build
	failure at arch_add_memory()
References: <20080701001656.e156585c.sfr@canb.auug.org.au>
	<486924FE.4090801@linux.vnet.ibm.com>
	<20080701013438.GT20457@bakeyournoodle.com>
In-Reply-To: <20080701013438.GT20457@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kbuild@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Mon, Jun 30, 2008 at 11:55:02PM +0530, Kamalesh Babulal wrote:
>> Hi Stephen,
>>
>> next-20080630 kernel build fails on powerpc, with randconfig
>>
>>   CC      arch/powerpc/mm/mem.o
>> arch/powerpc/mm/mem.c: In function ‘arch_add_memory’:
>> arch/powerpc/mm/mem.c:130: error: implicit declaration of function ‘create_section_mapping’
>> make[1]: *** [arch/powerpc/mm/mem.o] Error 1
>> make: *** [arch/powerpc/mm] Error 2
> 
> This problem exists in in 2.6.26-rc8, so it's not specifially linux-next
> realted.  The patch at:
> http://patchwork.ozlabs.org/linuxppc/patch?id=19347
> should fix it but is un-ACK'd ;P
Hi Tony,

Thanks, the patch fixes the build failure on the machine.

> 
> Yours Tony
> 
>   linux.conf.au    http://www.marchsouth.org/
>   Jan 19 - 24 2009 The Australian Linux Technical Conference!
> 


-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
