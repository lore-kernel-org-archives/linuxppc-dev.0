Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A59EDDFD1
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:19:40 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4I7JapD006454
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 02:19:37 -0500
Subject: "test" branch updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 18 May 2009 17:19:35 +1000
Message-Id: <1242631175.18075.54.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a quick note before I leave the office...

I've just pushed out a bunch of stuff to my "test" branch. There's a
couple of known breakage (iseries and 8xx) which will have to be sorted
out before that stuff goes into "next". hopefully in a couple of days.

Still... feel free to take a peek, test, etc...

Cheers,
Ben.
