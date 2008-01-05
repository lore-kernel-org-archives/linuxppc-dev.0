Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A0299DDE07
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 06:20:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] MTD for Taco
Date: Sat, 5 Jan 2008 20:19:54 +0100
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<477FCA53.8010103@pikatech.com>
In-Reply-To: <477FCA53.8010103@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801052019.55443.arnd@arndb.de>
Cc: Stefan Roese <sr@denx.de>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Sean MacLennan wrote:
> > You do break arch/ppc support with this patch. We have to still support
> > arch/ppc a few month, so please don't break this support for now.
> > =A0=20
> Gotcha. Is CONFIG_PPC_MERGED the right flag for things like this?

Yes, but it it's spelled CONFIG_PPC_MERGE, not CONFIG_PPC_MERGED.

	Arnd=20
