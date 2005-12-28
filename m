Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 67DBF6895C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 10:24:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 achim.machura@berghof.com
Date: Wed, 28 Dec 2005 22:58:02 +0000
References: <002501c60710$efc71270$34f1ff0a@beint.local>
In-Reply-To: <002501c60710$efc71270$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512282258.03332.arnd@arndb.de>
Subject: Re: AW: AW: Kernel cmdline
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 22 December 2005 16:01, Achim Machura wrote:
> i want check an argument given by the bootloader via commandline
> 
You should use module_param() for this, that will take care
of both kernel and module parameters, for more information,
see http://lwn.net/Articles/22197/.

	Arnd <><
