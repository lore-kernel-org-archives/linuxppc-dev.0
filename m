Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 700E32C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:52:30 +1100 (EST)
Message-ID: <1395291139.12479.315.camel@snotra.buserror.net>
Subject: Re: 3.16.6 build error: swsusp_booke.S:85: Error: invalid sprg number
From: Scott Wood <scottwood@freescale.com>
To: John Donnelly <john.d@servergy.com>
Date: Wed, 19 Mar 2014 23:52:19 -0500
In-Reply-To: <CAGtOQbTgXnxEHfuqtQ-BwpsnY=J2WktMFTNXysfYw9-cYprstQ@mail.gmail.com>
References: <CAGtOQbTgXnxEHfuqtQ-BwpsnY=J2WktMFTNXysfYw9-cYprstQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-19 at 17:58 -0500, John Donnelly wrote:
> Platform: Freescale  p4080--e500mc  ,
> 
> 
> Suggestions welcome . 
> 
> 
>  /bin/sh arch/powerpc/kernel/systbl_chk.sh
> arch/powerpc/kernel/systbl_chk.i
> make -f scripts/Makefile.build obj=arch/powerpc/kernel/vdso32
>   gcc -mbig-endian -m32 -Wp,-MD,arch/powerpc/kernel/.swsusp_booke.o.d
>  -nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.8.2/include
> -I/root/linux-3.13.6/arch/powerpc/include
> -Iarch/powerpc/include/generated  -Iinclude
> -I/root/linux-3.13.6/arch/powerpc/include/uapi
> -Iarch/powerpc/include/generated/uapi
> -I/root/linux-3.13.6/include/uapi -Iinclude/generated/uapi
> -include /root/linux-3.13.6/include/linux/kconfig.h -D__KERNEL__
> -Iarch/powerpc  -D__ASSEMBLY__ -Iarch/powerpc  -gdwarf-2          -c
> -o arch/powerpc/kernel/swsusp_booke.o
> arch/powerpc/kernel/swsusp_booke.S
> arch/powerpc/kernel/swsusp_booke.S: Assembler messages:
> arch/powerpc/kernel/swsusp_booke.S:85: Error: invalid sprg number
> arch/powerpc/kernel/swsusp_booke.S:87: Error: invalid sprg number
> 
You need commit b58a7bd6df7b61446b833a7c72f8a1f11066e0b0.

-Scott
