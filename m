Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id CC210DDF55
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Apr 2008 19:27:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 dhlii@dlasys.net
Subject: Re: HAVE_CONFIG
Date: Tue, 29 Apr 2008 11:27:13 +0200
References: <4816B372.10608@dlasys.net>
In-Reply-To: <4816B372.10608@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804291127.14666.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 29 April 2008, David H. Lynch Jr. wrote:
> =A0 =A0 Why does CONFIG_PPC set CONFIG_HAVE_IDE ?

Because it's possible to build ide drivers on the powerpc architecture.
It means you get the option to enable to disable the old ATA (IDE) drivers.

	Arnd <><
