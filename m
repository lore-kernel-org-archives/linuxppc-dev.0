Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12726DDFA6
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:01:22 +1100 (EST)
Message-ID: <47D1589B.5080006@freescale.com>
Date: Fri, 07 Mar 2008 09:00:43 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
References: <200803071521.00383.laurentp@cse-semaphore.com>
In-Reply-To: <200803071521.00383.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:

> Does anyone have any clue regarding what could write to the dpram ? I thought 
> about some CPM peripheral set up by the boot loader, but my board 
> initialization code calls cpm2_reset() long before initializing SCC1.

I'm not familar with the CPM, but in cpm_common.c are a bunch of functions to
manage memory allocated of the DPRAM.  You might want to see who's using those
functions, and how.

-- 
Timur Tabi
Linux kernel developer at Freescale
