Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 4F353DDE46
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 14:20:52 +1000 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [ofa-general] [PATCH 5/5] ehca: Support small QP queues
References: <200707201604.17991.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 20 Jul 2007 21:20:49 -0700
In-Reply-To: <200707201604.17991.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Fri, 20 Jul 2007 16:04:17 +0200")
Message-ID: <adawswu5qvy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, fenkes@de.ibm.com, stefan.roscher@de.ibm.com,
	linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks, applied.  I fixed this up myself to work with commit 20c2df83,
which got rid of the destructor argument to kmem_cache_create() -- you
probably want to check my tree to make sure it's OK.

Also the same as I said before about checkpatch.pl's warning:

WARNING: externs should be avoided in .c files
#337: FILE: drivers/infiniband/hw/ehca/ehca_pd.c:91:
+	extern struct kmem_cache *small_qp_cache;

please fix that up when you get a chance
