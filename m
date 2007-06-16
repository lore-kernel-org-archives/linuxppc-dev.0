Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF47CDDE39
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 04:09:57 +1000 (EST)
Date: Sat, 16 Jun 2007 09:10:09 -0700
From: Brad Boyer <flar@allandria.com>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Message-ID: <20070616161009.GA26989@cynthia.pants.nu>
References: <200706141739.12754.mb@bu3sch.de>
	<1181955074.26853.105.camel@localhost.localdomain>
	<200706161504.41168.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200706161504.41168.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2007 at 03:04:41PM +0200, Michael Buesch wrote:
> Where in the kernel code are the PMU messages handled?

The main place to look would be drivers/macintosh/via-pmu.c, and
it looks like the bulk of the work is being done in the function
pmu_handle_data(). You might want to take a look at other parts
of the driver as well.

	Brad Boyer
	flar@allandria.com
