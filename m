Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 6E62D67B50
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Apr 2006 09:07:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Accessing physical memory
Date: Sun, 9 Apr 2006 01:07:16 +0200
References: <200604082352.55490.antonio.dibacco@aruba.it>
In-Reply-To: <200604082352.55490.antonio.dibacco@aruba.it>
MIME-Version: 1.0
Message-Id: <200604090107.17132.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 08 April 2006 23:52, Antonio Di Bacco wrote:
> How can I access the physical memory? Can I MMAP for example /dev/mem? Is 
> there a simpler way?

/dev/mem access is the most simple way. A cleaner solution is usually to
write your own simple character device driver for the stuff you want to
access in memory.

Depending on why you want to access memory, slram may be the right
driver, e.g. when you want to store a file system there.

	Arnd <><
