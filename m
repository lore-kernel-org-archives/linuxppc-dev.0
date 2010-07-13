Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C003FB6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 08:13:40 +1000 (EST)
Subject: Re: [PATCH 1/9 v1.01] Add Synopsys DesignWare HS USB OTG
	Controller driver.
From: fushen chen <fchen@apm.com>
To: David Brownell <david-b@pacbell.net>
In-Reply-To: <582531.52335.qm@web180310.mail.gq1.yahoo.com>
References: <582531.52335.qm@web180310.mail.gq1.yahoo.com>
Content-Type: text/plain
Date: Tue, 13 Jul 2010 15:13:33 -0700
Message-Id: <1279059214.29212.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, chuck@theptrgroup.com, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-07-12 at 16:55 -0700, David Brownell wrote:
> Please remove all the changes not related to
> this Synopsis IP ... 
Could you clarify what is not Synopsis IP related in the patch?
 
> and make the OTG functionality
> key on the generic OTG symbol, not a DW-specific one.
> 
> 
Use "drivers/usb/otg/otg.c and include/linux/usb/otg.h"?

Thanks,
Fushen 
