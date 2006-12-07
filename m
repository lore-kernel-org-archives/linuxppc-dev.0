Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7425A67C8B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 21:09:31 +1100 (EST)
Message-ID: <4577E850.6040500@pobox.com>
Date: Thu, 07 Dec 2006 05:09:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 3/16] Spidernet RX Locking
References: <20061206223223.GH17931@austin.ibm.com>
	<20061206233134.GC4649@austin.ibm.com>
In-Reply-To: <20061206233134.GC4649@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> The RX packet handling can be called from several
> places, yet does not protect the rx ring structure.
> This patch places the ring buffer pointers under a lock.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

This is a HUGELY invasive patch.  A sledgehammer.

What /specifically/ are these "several places", and what other 
non-sledgehammer approaches were discarded before arriving at this one?

	Jeff
