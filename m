Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E74C067B1C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 00:09:40 +1000 (EST)
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150600470.23600.158.camel@localhost.localdomain>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600470.23600.158.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1150726157.9022.12.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 19 Jun 2006 09:09:19 -0500
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

On Sat, 2006-06-17 at 22:14, Benjamin Herrenschmidt wrote:

> I'm not too fan of the big table in the kernel however. I'd rather have
> it in the device-tree.

We are waiting for this release to get into the mainline,
and for your proposed rewrite to be accepted.  We have folks
here who are on deck to totally modify this to accommodate
your proposal via the Device Tree file.

But we're not going to read your mind to get there. :-)

jdl
