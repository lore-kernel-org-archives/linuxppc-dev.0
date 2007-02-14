Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6D3BDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:28:06 +1100 (EST)
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45D29AE5.7090004@freescale.com>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 16:27:57 +1100
Message-Id: <1171430877.20192.133.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 23:15 -0600, Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> 
> > I think that:
> > 
> >  - The /chosen node should be present in the .dts even if empty
> 
> Only one DTS file has it.  It's been removed from every other DTS.  Are 
> you should that instead of removing the last one, I should *add* one to 
> the other DTS files?

Or just leave them alone for now.

> >  - I don't see why you are removing linux,boot-cpu from the
> > documentation ! It's a fairly important property. 
> 
> No, it's a dead property.  Specifying linux,boot-cpu in the DTS is 
> obsolete and deprecated.  If you specify it, the device tree compiler 
> complains.  The proper way to specify the device tree is with the -b 
> parameter to dtc.

Ah indeed, my bad. We moved that to a header field didn't we ?

/me grumbles about kexec... :-)

Ben.
