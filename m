Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEF3E1007D1
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 07:52:00 +1000 (EST)
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
From: fushen chen <fchen@apm.com>
To: David Brownell <david-b@pacbell.net>
In-Reply-To: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
References: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Jun 2010 14:51:54 -0700
Message-Id: <1277934714.16379.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de, fushen.chen@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David,

AppliedMicro has PPC-405EX and PPC-460EX SOC using this controller.
There will be another arch/powerpc/boot/dts/canyonlands.dts for
PPC-460EX board.

Thanks,
Fushen

 
 
On Tue, 2010-06-29 at 15:41 -0700, David Brownell wrote:
> Good -- MUSB won't be the only one.  ;)
> 
> Could you mention a few Linux-enabled chips which
> include this controller?
> 
> 
> >  arch/powerpc/boot/dts/kilauea.dts |   15 +
> 
> Also, please provide a clean patch that only
> includes the driver, and split PPC hooks into
> a separate patch.
> 
> 
> 
