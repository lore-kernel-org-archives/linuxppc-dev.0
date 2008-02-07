Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 45742DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 18:26:35 +1100 (EST)
Message-ID: <47AAB2AA.7070707@pikatech.com>
Date: Thu, 07 Feb 2008 02:26:34 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: asm-offsets.c
References: <47AA8C7D.3030109@pikatech.com> <20080207045129.GA4324@lst.de>
	<20080207064934.GC14201@localdomain>
	<20080207065540.GA9488@lst.de> <47AAACF9.9030901@pikatech.com>
	<20080207071620.GD14201@localdomain>
In-Reply-To: <20080207071620.GD14201@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> CLOCK_REALTIME_RES is defined in include/asm/asm-offsets.h, which is
> generated from asm-offsets.c as part of the build.
>
> Your config builds fine here, so please post the actual error that you
> are seeing during the build?
>   
Mine is off one line from Christoph's because I have the patch I posted 
installed. I just comment out the #ifdef to get the error. Here is the 
output after a make clean.

make -C /home/seanm/taco/for-2.6.25/ 
make: Entering directory `/home/seanm/taco/for-2.6.25'
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  CC      arch/powerpc/kernel/asm-offsets.s
arch/powerpc/kernel/asm-offsets.c: In function 'main':
arch/powerpc/kernel/asm-offsets.c:317: warning: asm operand 0 probably doesn't match constraints
arch/powerpc/kernel/asm-offsets.c:317: error: impossible constraint in 'asm'
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
make: Leaving directory `/home/seanm/taco/for-2.6.25'

Compilation exited abnormally with code 2 at Thu Feb  7 02:24:13


The warp was originally called the taco, thus the directory name.

Cheers,
   Sean
