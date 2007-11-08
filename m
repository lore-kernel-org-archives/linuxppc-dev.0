Return-Path: <ralf@linux-mips.org>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by ozlabs.org (Postfix) with ESMTP id 25A11DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 20:53:36 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:13471 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022405AbXKHJsd (ORCPT <rfc822;linuxppc-dev@ozlabs.org>);
	Thu, 8 Nov 2007 09:48:33 +0000
Date: Thu, 8 Nov 2007 09:48:25 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Message-ID: <20071108094825.GB10665@linux-mips.org>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135849.207149000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071107135849.207149000@sipsolutions.net>
Cc: Bryan Wu <bryan.wu@analog.com>, linux-mips@linux-mips.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, linux-pm@lists.linux-foundation.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 07, 2007 at 02:58:00PM +0100, Johannes Berg wrote:

> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Cheers,

  Ralf
