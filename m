Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 77DE4DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 11:06:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
Date: Sat, 15 Sep 2007 03:02:23 +0200
References: <200709150221.57825.arnd@arndb.de>
	<1189811264.24878.3.camel@localhost.localdomain>
In-Reply-To: <1189811264.24878.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709150302.23743.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 15 September 2007, Josh Boyer wrote:
> On Sat, 2007-09-15 at 02:21 +0200, Arnd Bergmann wrote:
> > Since the PPE on cell is an in-order core, it suffers significantly
> > from wrong instruction scheduling. This adds an Kconfig option that
> > enables passing -mtune=cell to gcc in order to generate object
> > code that runs well on cell.
> 
> Which version of gcc supports that?
> 

gcc-4.3 will be the first official release that has everything in it,
and I think 4.1 has some parts. However, there are many patched gcc
versions in various distributions, so I tried to avoid being too
specific about the version here.

Of course, on gcc versions that don't support -mtune=cell, the 
Kconfig option does not make a difference.

	Arnd <><
