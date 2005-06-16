Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id C29BA679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 16:48:15 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j5G6rVYh024771
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 09:53:32 +0300 (EEST)
Message-ID: <42B11F5B.2050706@intracom.gr>
Date: Thu, 16 Jun 2005 09:42:35 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42B049DC.7040703@ru.mvista.com>
	<7e2a8c0e483e5dfdc532c47d20776bbd@freescale.com>
In-Reply-To: <7e2a8c0e483e5dfdc532c47d20776bbd@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Let me hop in here...

Have you thought about breaking up the structures per
cpm peripheral?

Some registers are unique for each processor family, but
others are (almost) common to all.

For example SCC parameters & stuff are the same on 8xx/82xx ...

IMHO keeping one definition in the tree for these will make
keeping them in sync easier.

Then the main header file will be the definitions of the
unique registers, a number of defines for the structures offsets
and a list of included files for the common peripherals...

Regards

Pantelis
