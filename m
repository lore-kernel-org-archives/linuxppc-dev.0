Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id CDA59DE00C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 18:38:59 +1100 (EST)
MIME-Version: 1.0
Subject: RE: reprogramming boot flash from live kernel
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 31 Jan 2007 08:38:57 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E622D4A@aquib01a>
In-Reply-To: <BAY117-F2788BF76C2EAE39F2FDB99C8A50@phx.gbl>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Eric Nuckols" <jrocnuck@hotmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Has anybody reprogrammed their bootup flash image while running a live
linux=20
> kernel?
I think that's not a good thing to do. The kernel could decide to load
something from the flash filesystem that you've overwritten and BOOM!!
Let me know if you find a safe way to do it.

Bye,
Antonio.
