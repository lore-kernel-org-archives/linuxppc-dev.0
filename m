Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kn.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8DBB7DDED3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 07:18:01 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kn.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	m47L9W701973
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 21:09:32 GMT
Message-ID: <48221A5F.6020306@nortel.com>
Date: Wed, 07 May 2008 15:08:47 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: error building 2.6.25 for G5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm getting the following error when building 2.6.25.  Has anyone else 
seen anything like this?  This is using gcc 3.4.3.


   CALL 
/home/cfriesen/kernels/2.6.25/linux-2.6.25/scripts/checksyscalls.sh
   CHK     include/linux/compile.h
   CALL 
/home/cfriesen/kernels/2.6.25/linux-2.6.25/arch/powerpc/kernel/systbl_chk.sh
   AS      arch/powerpc/kernel/systbl.o
   OBJCOPY arch/powerpc/kernel/vdso64/vdso64.so
BFD: arch/powerpc/kernel/vdso64/vdso64.so: The first section in the 
PT_DYNAMIC segment is not the .dynamic section
/home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-objcopy: 
arch/powerpc/kernel/vdso64/vdso64.so: Bad value
BFD: arch/powerpc/kernel/vdso64/vdso64.so: The first section in the 
PT_DYNAMIC segment is not the .dynamic section
/home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-objcopy: 
arch/powerpc/kernel/vdso64/vdso64.so: Bad value
make[3]: *** [arch/powerpc/kernel/vdso64/vdso64.so] Error 1
make[2]: *** [arch/powerpc/kernel/vdso64] Error 2
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [sub-make] Error 2



Chris
