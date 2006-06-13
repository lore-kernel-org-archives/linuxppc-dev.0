Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C806467B22
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 12:09:19 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306907E1B@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306907E1B@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 12:09:06 +1000
Message-Id: <1150164546.9816.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-09 at 17:25 +0800, Zang Roy-r61911 wrote:

> Any comment?

Not right now. We'll have to rework this a bit on top of my current
changes to the powerpc interrupt stuff. I'll post patches soon.

Ben.
