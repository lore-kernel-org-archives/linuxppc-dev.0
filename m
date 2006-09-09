Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2D91E67B5A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Sep 2006 05:22:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: asm/*.h files missing for ppc arch.
Date: Sat, 9 Sep 2006 21:21:49 +0200
References: <BAY110-F378469920DE25DF7AB6C28B2340@phx.gbl>
In-Reply-To: <BAY110-F378469920DE25DF7AB6C28B2340@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609092121.49915.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Saturday 09 September 2006 20:34 schrieb Ming Liu:
> default:
> =A0 $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules
> endif

It's usually easier if you add your module to your copy of the kernel
sources and build it along with all the other modules.

	Arnd <><
