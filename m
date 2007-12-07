Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B2B06DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 23:04:01 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][POWERPC] Provide a way to protect 4k subpages when using
	64k pages
Date: Fri, 7 Dec 2007 13:03:41 +0100
References: <18264.58263.818005.757831@cargo.ozlabs.ibm.com>
In-Reply-To: <18264.58263.818005.757831@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712071303.42413.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 December 2007, Paul Mackerras wrote:
> I have re-purposed the ioperm system call for this. =A0The old ioperm
> system call never did anything (except return an ENOSYS error) and in
> fact never could have actually been useful for anything on the PowerPC
> architecture, so nothing ever used it.

Couldn't there be a program that relies on ioperm to return -ENOSYS on
powerpc in order to fall back on some other method of I/O access?

The risk of actually breaking something is certainly low, but I think
you can never be sure here, so why not use a new syscall number?

	Arnd <><
