Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9CE6BDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 03:28:11 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4AHT5Bv021826
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:29:05 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4AHS7ux496538
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:28:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4AHS7Nl007101
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:28:07 -0400
Date: Thu, 10 May 2007 12:28:06 -0500
To: Rob Landley <rob@landley.net>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Message-ID: <20070510172806.GE4452@austin.ibm.com>
References: <200705092203.26042.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200705092203.26042.rob@landley.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Rob,

On Wed, May 09, 2007 at 10:03:25PM -0400, Rob Landley wrote:
> I've been puttering around with my Firmware Linux project trying to add
> powerpc as a supported platform.  I can build kernels that qemu can boot (such
> as a "prep" kernel) using ARCH=ppc, but that one doesn't support make
> headers_install.
> 
> Using ARCH=powerpc makes headers_install work, but there's no kernel .config 
> I've been able to come up with that generates a kernel I can boot under qemu.

Hmm. I'm not a boot expert, (although many people on this list are). 
Any hint of where the boot is failing?  Maybe qemu is not setting up
a device tree? 

> what's the status of the 
> ppc->powerpc migration, 

pretty far along; bits f ppc are getting nuked regularly.

> and is there any known way to get ARCH=powerpc to 
> build a kernel qemu can boot?

Dunno...

--linas
