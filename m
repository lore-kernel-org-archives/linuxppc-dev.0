Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id EC781DDE39
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 07:04:02 +1000 (EST)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ehca: map 4k firmware context of cq, qp to user space
References: <200708021139.31695.hnguyen@linux.vnet.ibm.com>
	<200708021608.16436.arnd@arndb.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 02 Aug 2007 14:03:59 -0700
In-Reply-To: <200708021608.16436.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 2 Aug 2007 16:08:15 +0200")
Message-ID: <adawswd3ayo.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	paulus@samba.org, general@lists.openfabrics.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > remap_4k_pfn is defined in terms of remap_pfn_range if the base page
 > size if 4k, so you don't need this #ifdef afaics.

Good point.  I'll wait for an updated patch.
