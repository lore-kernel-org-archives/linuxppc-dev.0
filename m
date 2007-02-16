Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CB8DEDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 09:40:56 +1100 (EST)
Message-ID: <45D632F3.3000509@freescale.com>
Date: Fri, 16 Feb 2007 16:40:51 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: What happened to include/asm-ppc??
References: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>	<E6C97B4B-F3DF-4AEC-A225-60DC6AE05691@freescale.com>
	<200702162150.44997.arnd@arndb.de>
In-Reply-To: <200702162150.44997.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Arnd Bergmann wrote:

> That shouldn't be the case, the headers from asm-powerpc should be
> sufficient for all 32 and 64 bit user apps, if not then you should
> really report that as a bug.

I thought applications weren't supposed to include kernel header files?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
