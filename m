Return-Path: <SRS0+33372e7501053477290c+1346+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBE6ADDF9E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 16:44:21 +1000 (EST)
Subject: Re: [PATCH 13/14] powerpc: add ps3 platform system bus support
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070430155823.GA30344@aepfle.de>
References: <4563D02F.9010307@am.sony.com>
	<20070430104714.GA25815@aepfle.de> <4636100C.7020006@am.sony.com>
	<20070430155823.GA30344@aepfle.de>
Content-Type: text/plain
Date: Tue, 01 May 2007 07:44:11 +0100
Message-Id: <1178001851.3085.137.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-30 at 17:58 +0200, Olaf Hering wrote:
> On Mon, Apr 30, Geoff Levand wrote:
> 
> > > The generated modalias files do not match anything.
> >  
> > Module support is still todo.  I am just now started on it.  David
> > Woodhouse sent a few patches, but I just merged them in without
> > testing.
> 
> This is my version, compile tested.

I have no particular objection to this, but would observe that it's more
normal to have the number->name mapping done in userspace by modprobe,
rather than inside the kernel.

For now I'd just added explicit aliases like 'MODULE_ALIAS("ps3:3");' to
the modules in question, because I hadn't yet worked out how to do all
the mod_devicetable stuff to pick it out of the match_id in the driver
structure.

-- 
dwmw2
