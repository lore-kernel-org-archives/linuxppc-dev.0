Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 5BB39DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 10:22:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: What happened to include/asm-ppc??
Date: Sat, 17 Feb 2007 00:22:23 +0100
References: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>
	<200702162150.44997.arnd@arndb.de> <45D632F3.3000509@freescale.com>
In-Reply-To: <45D632F3.3000509@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702170022.24595.arnd@arndb.de>
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

On Friday 16 February 2007 23:40, Timur Tabi wrote:
> > That shouldn't be the case, the headers from asm-powerpc should be
> > sufficient for all 32 and 64 bit user apps, if not then you should
> > really report that as a bug.
> 
> I thought applications weren't supposed to include kernel header files?
> 
Right, but glibc depends on them. We now have a mechanism of installing
a subset of the kernel headers with 'make headers_install' in order
to be used by glibc. This currently will install a set of the asm-powerpc
files, but we got rid of all user dependencies on asm-ppc headers.

	Arnd <><
