Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF439B7D1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 13:45:15 +1000 (EST)
Subject: Re: mmio_nvram.c users ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100525110050.GH24511@zod.rchland.ibm.com>
References: <1274773439.1931.238.camel@pasglop>
	<20100525110050.GH24511@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 29 May 2010 13:45:04 +1000
Message-ID: <1275104704.1931.528.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-05-25 at 07:00 -0400, Josh Boyer wrote:
> On Tue, May 25, 2010 at 05:43:59PM +1000, Benjamin Herrenschmidt wrote:
> >Hi folks !
> >
> >Anybody aware of anything other than Cell using that driver ?
> >
> >I'd like to make it a platform driver instead of having something that
> >pokes at anything that has a "device_type" set to "nvram" (which is
> >gross and bogus). But I need to know what platforms to fixup...
> 
> Why bother?  You could just use either drivers/mtd/devices/{phram.c or slram.c}
> and get the same functionality at that point, couldn't you?

Won't that break existing userspace ?

Cheers,
Ben.
