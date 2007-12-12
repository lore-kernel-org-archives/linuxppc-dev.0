Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id CB308DDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 07:29:15 +1100 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls if necessary
References: <200712101859.11218.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Dec 2007 12:29:09 -0800
In-Reply-To: <200712101859.11218.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Mon, 10 Dec 2007 18:59:10 +0100")
Message-ID: <ada3au78xnu.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks, applied.

With your next batch of patches for 2.6.25, could you clean up:

 > --- a/drivers/infiniband/hw/ehca/hcp_if.c
 > +++ b/drivers/infiniband/hw/ehca/hcp_if.c
 > @@ -89,6 +89,7 @@
 >  #define HCALL9_REGS_FORMAT HCALL7_REGS_FORMAT " r11=%lx r12=%lx"
 >  
 >  static DEFINE_SPINLOCK(hcall_lock);
 > +extern int ehca_lock_hcalls;

and move that extern declaration into an appropriate header file?

Thanks...
