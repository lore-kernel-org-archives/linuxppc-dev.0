Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id D9FD1DE035
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 17:00:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/14] ps3: rename interrupt symbols
Date: Thu, 25 Jan 2007 07:00:45 +0100
References: <45B8187F.5060007@am.sony.com>
	<1169697011.24996.47.camel@localhost.localdomain>
In-Reply-To: <1169697011.24996.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250700.45997.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 04:50, Benjamin Herrenschmidt wrote:
> On Wed, 2007-01-24 at 18:39 -0800, Geoff Levand wrote:
> > Rename some PS3 interrupt symbols to avoid name clashes and aid debugging.
> > No change to code.
> > 
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Might be even better to do
> 
> struct ps3_irq_bitmap
> struct ps3_irq_priv
>
> But that's already better than what was there before. Nice to see you
> seem to agree with my initial rant about those names :-)

Right.

> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
