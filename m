Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6795CB7080
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 04:18:38 +1100 (EST)
Subject: Re: Starting bare metal application on second core of P2020
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B7BE719.9070107@embedded-sol.com>
Date: Wed, 17 Feb 2010 11:18:26 -0600
Message-Id: <4EDB4AFB-ADE3-428D-AEEA-98A467E75C4E@kernel.crashing.org>
References: <4B7BE719.9070107@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 17, 2010, at 6:54 AM, Felix Radensky wrote:

> Hi,
>=20
> We'd like to run Linux on core0 of P2020 and some bare metal =
application running without OS
> on core1. Is it possible to start this application from Linux ? I've =
seen example of running 2 copies
> of Linux in AMP mode, in which case both are started from u-boot. I'd =
like to leave core1 in
> reset, start Linux on core0 from u-boot and load bare metal =
application from Linux. If this
> possible, where can I learn about the procedure ?

There is no of the shelf support for this.  It would be reasonable easy =
to create a driver to load up your application for Linux and kick the =
second cpu to start it.

- k=
