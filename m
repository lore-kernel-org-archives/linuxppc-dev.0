Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 019B267C33
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 10:04:05 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address
	to determine pending work requests
References: <200611202354.13030.hnguyen@linux.vnet.ibm.com>
	<adaslgcg30n.fsf@cisco.com>
	<200611221029.10077.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 22 Nov 2006 15:04:01 -0800
In-Reply-To: <200611221029.10077.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Wed, 22 Nov 2006 10:29:09 +0100")
Message-ID: <adaslgbaxsu.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > We found this bug actually through a code review by random. Since
 > (un)fortunately the queue pages were layouted in order, we've not
 > seen it earlier. It's certainly a bug and can cause kernel panic 
 > if above observation is not met, probably in stress situation
 > of system. That means the "former" code accesses next page that 
 > it has not allocated.

OK.  After thinking about this, I'm going to queue it for 2.6.20 --
we're _way_ too close to the 2.6.19 final release to put in patches
that aren't either small and obvious, or fix a problem someone hit in
real life.

 - R.
