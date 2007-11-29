Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id E7701DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 21:34:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Increase the upper bound on NR_CPUS.
Date: Thu, 29 Nov 2007 11:33:40 +0100
References: <20071129041603.GM24243@bakeyournoodle.com>
In-Reply-To: <20071129041603.GM24243@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711291133.41188.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 29 November 2007, Tony Breeds wrote:
> why not?

In the past I've seen run-time problems because some parts of the
code kmalloc NR_CPUS sized arrays, which can easily grow beyond
the kmalloc limit of 128kb. Have you tried running some tests
on a small machine with the big NR_CPUS?

	Arnd <><
