Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4F24867CB7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 09:33:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/9] [POWERPC] move Efika support files into platforms/52xx
Date: Mon, 27 Nov 2006 23:33:01 +0100
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<200611272256.44623.arnd@arndb.de>
	<1164665556.5350.40.camel@localhost.localdomain>
In-Reply-To: <1164665556.5350.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611272333.01840.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 November 2006 23:12, Benjamin Herrenschmidt wrote:
> > I know you're only moving this code, but shouldn't this really use the
> > code from arch/powerpc/kernel/rtas_pci.c? If it doesn't work out of
> > the box, I guess we should rather split out the pseries specific
> > bits from it and make the common parts more generic.
> 
> I looked into it and decided to wait before trying to do that. The 32
> bits versions are very small so it doesn't matter much anyway.

Ok, that's probably true for the current platforms. It may become more
useful to merge if we get more platforms that need extended config
space registers or multiple PCI buses.

	Arnd <><
