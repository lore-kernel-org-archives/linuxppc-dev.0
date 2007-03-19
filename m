Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 507C4DDEC5
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 01:49:21 +1100 (EST)
Subject: Re: [PATCH 3/5] powermac: disallow pmu sleep notifiers from
	aborting sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070319105359.356866000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105359.356866000@sipsolutions.net>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 15:49:16 +0100
Message-Id: <1174315756.5044.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-19 at 11:53 +0100, Johannes Berg wrote:
> plain text document attachment (003-less-pmu-sleep-notifier.patch)
> Tracing through the code, no current PMU sleep notifier can abort sleep.
> Since no new PMU sleep notifiers should be added, this patch simplifies the
> code and removes the ability to abort sleep.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ben.
