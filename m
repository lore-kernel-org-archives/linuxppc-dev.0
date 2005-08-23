Return-Path: <SRS0+b9308c1fde813118a622+730+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1E43680D5
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 09:10:47 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <68765056-7D19-42A4-9E25-22C036AE5E05@freescale.com>
References: <1124815395.29448.26.camel@hades.cambridge.redhat.com>
	<68765056-7D19-42A4-9E25-22C036AE5E05@freescale.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 00:10:38 +0100
Message-Id: <1124838638.5248.81.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-08-23 at 12:04 -0500, Kumar Gala wrote:
> If the machine is locking hard it could be check stopping due to  
> getting a second machine check.

Perhaps... but it's not the _second_ machine check. We already take 33
of them, and recover, while the i8042 driver is poking for hardware. We
also tend to survive a few while the 8250 driver is poking... but not
all of them.

Some timing issue with recovering and then causing another machine check
in quick succession?

-- 
dwmw2
