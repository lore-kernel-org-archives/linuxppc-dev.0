Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 146CFDDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 22:28:43 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1ABTIUW020936
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 06:29:18 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1ABSeCi190958
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 06:28:40 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1ABSdUX026581
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 06:28:40 -0500
Date: Tue, 10 Feb 2009 06:28:25 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Li Jun (Aaron)" <aaronleefly@gmail.com>
Subject: Re: linux2.6.23-rc2 build errors--kernel/traps.c
Message-ID: <20090210112825.GA31024@zod.rchland.ibm.com>
References: <001801c98b38$458b5b40$d0a211c0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001801c98b38$458b5b40$d0a211c0$@com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2009 at 12:30:11PM +0800, Li Jun (Aaron) wrote:
>Hi,
>
>When I make zImage, the errors below came out. Any tips?
>
>
>
>[linux-2.6-virtex]$ make zImage
>
>  CHK     include/linux/version.h
>
>  CHK     include/linux/utsrelease.h
>
>  CALL    scripts/checksyscalls.sh
>
>  CHK     include/linux/compile.h
>
>dnsdomainname: Unknown host
>
>  CC      arch/ppc/kernel/traps.o
>
>arch/ppc/kernel/traps.c:47: error: 'xmon' undeclared here (not in a
>function)
>
>make[1]: *** [arch/ppc/kernel/traps.o] Error 1
>
>make: *** [arch/ppc/kernel] Error 2

That is a really old, non-final kernel release.  I'm not sure why
you are using that.  arch/ppc isn't supported any longer.

josh
