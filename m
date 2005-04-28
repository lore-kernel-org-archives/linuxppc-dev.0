Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 892CD67B37
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2005 02:25:30 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B25@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B25@exnet.3il.fr>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1114705509.4084.3.camel@gleep>
Mime-Version: 1.0
Date: Thu, 28 Apr 2005 11:25:10 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: RE : Booting linux for 405EP --> mem_pieces_find( ) nightmare
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-04-28 at 05:36, Garcia Jérémie wrote:

> So the return of this function was incoherent and drove me to a kernel
> panic.

> As a conclusion I just defined my own board info structure in the
> platform_init() function:

Oh no!

We're going to have to work on isolating the bd_t virus
with my patch on the linuxppc-embedded list...

*sigh*

jdl
