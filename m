Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id A9252DDE2E
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:05:48 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
References: <200709261143.24735.fenkes@de.ibm.com>
	<200709261145.51926.fenkes@de.ibm.com>
	<18179.943.277895.633795@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 03 Oct 2007 11:05:44 -0700
In-Reply-To: <18179.943.277895.633795@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 3 Oct 2007 12:51:27 +1000")
Message-ID: <adave9odqfb.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Klein <tklein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan-Bernd Themann <themann@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <pmac@au1.ibm.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > Replace struct ibmebus_dev and struct ibmebus_driver with struct of_device
 > > and struct of_platform_driver, respectively. Match the external ibmebus
 > > interface and drivers using it.
 > > 
 > > Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
 > 
 > If not, then you need to get an Acked-by and an agreement that this
 > change can go via the powerpc.git tree from Roland Dreier and Jeff
 > Garzik.

I don't see anything objectionable in the infiniband parts of the
patch -- I don't have any way to test the changes but it all looks
like a straightforward conversion to a new platform API.  So:

Acked-by: Roland Dreier <rolandd@cisco.com>

 - R.
