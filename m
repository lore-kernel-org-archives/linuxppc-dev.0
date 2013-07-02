Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D63062C0332
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 18:20:48 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r628Kgab028715
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jul 2013 03:20:43 -0500
Message-ID: <1372753241.3616.3.camel@pasglop>
Subject: "server mode" on SMU based machines (Quad G5, iMac G5, ...)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Jul 2013 18:20:41 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

People keep asking about it ... so I rewrote the tool I whipped up
a while ago and lost :-)

https://gate.crashing.org/~benh/smu_servermode.tar.bz2

It's pretty primitive. Run as root without arguments to query the
current HW setting. Run with argument "0" or "1" to clear or set
the server mode in the SMU.

For those who don't know, "server mode" is when the machine turns
back on automatically after a power failure.

Cheers,
Ben.
