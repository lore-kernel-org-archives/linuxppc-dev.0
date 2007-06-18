Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id EE561DDEFF
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:26:41 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/1] Add support for MSI on Axon-based Cell systems
Date: Tue, 19 Jun 2007 00:26:28 +0200
References: <c9982de4efc00ba092d6982a61f98ed2765130bf.1182156508.git.michael@ellerman.id.au>
In-Reply-To: <c9982de4efc00ba092d6982a61f98ed2765130bf.1182156508.git.michael@ellerman.id.au>
MIME-Version: 1.0
Message-Id: <200706190026.28608.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 18 June 2007, Michael Ellerman wrote:
> This patch adds support for the setup and decoding of MSIs
> on Axon-based Cell systems, using the MSIC mechanism.
> 
> This involves setting up an area of BE memory which the Axon
> then uses as a FIFO for MSI messages. When one or more MSIs
> are decoded by the MSIC we receive an interrupt on the MPIC,
> and the MSI messages are written into the FIFO. At the moment
> we use a 64KB FIFO, one per MSIC/BE.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
