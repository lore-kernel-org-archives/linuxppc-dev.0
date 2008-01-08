Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10C0EDDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 15:02:42 +1100 (EST)
Subject: Re: [PATCH][POWERPC] Workaround for iommu page alignment (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080108034824.GA7983@lixom.net>
References: <1199742359.6734.14.camel@pasglop>
	<1199748862.6734.20.camel@pasglop>  <20080108034824.GA7983@lixom.net>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 15:02:24 +1100
Message-Id: <1199764944.6734.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> And sloppy of me to not catch it. Anyway:
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> I wonder how long until there's a device that has some other < PAGE_SIZE
> alignment bug^Wrequirement that we'll need to meet too. :(

Yeah, it's a worry...

Ben.
