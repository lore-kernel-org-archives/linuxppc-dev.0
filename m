Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D11BD67B15
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 00:04:56 +1000 (EST)
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150600056.23600.152.camel@localhost.localdomain>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1150725866.9022.5.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 19 Jun 2006 09:04:27 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-06-17 at 22:07, Benjamin Herrenschmidt wrote:

> 
> You don't have any way to freeze the timebase ? (No GPIO controlling
> TBEN ?) It's pretty nasty to rely on software sync,

I will investigate this option and follow up with a patch,
assuming that there is a HW solution for your suggestion.

> especially if it's supposed to be an example design ...

Who said that? ;-)

jdl
