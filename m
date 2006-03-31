Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id E638A679EB
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:29:06 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/2] Base pSeries PCIe support
Date: Sat, 1 Apr 2006 00:28:43 +0200
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
In-Reply-To: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604010028.43685.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Saturday 01 April 2006 00:02 schrieb Jake Moilanen:
> Here are the two base patches for PCIe on pSeries for 2.6.17.
>
> This is enough to probe, find, configure, and run basic I/O to PCIe
> enabled devices.

Does this use the draft PCIe bindings from Sun, or something else?
Is it compatible with the way that Apple represents PCIe devices
as plain PCI?

I'm just curious.

	Arnd <><
