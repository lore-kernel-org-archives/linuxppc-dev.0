Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 08BCC67C4B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 03:50:55 +1100 (EST)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
References: <200611052140.38445.hnguyen@de.ibm.com>
	<200611060045.59074.arnd@arndb.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 08:50:44 -0800
In-Reply-To: <200611060045.59074.arnd@arndb.de> (Arnd Bergmann's message of
	"Mon, 6 Nov 2006 00:45:58 +0100")
Message-ID: <adaslgwo6xn.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > I'd simply move the memset into the alloc function and get rid of the
 > constructor here.

Slightly better still would be to use kmem_cache_zalloc() (save a tiny
bit of text by getting rid of the call to memset).

 - R.
