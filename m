Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 2A9DC67BAD
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 10:07:23 +1100 (EST)
To: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe
	address	to determine pending work requests
References: <OFCFF36ACF.6FF07D9E-ONC125722F.00499C9C-C125722F.0049F685@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Nov 2006 15:07:20 -0800
Message-ID: <adafyc88mvr.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <raisch@de.ibm.com>,
	linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > That's fair. I understand your decision. And thanks for queueing for
 > 2.6.20. Can you please brief me on patch procedures for post-2.6.19?

What do you mean by post-2.6.19?  Things go into 2.6.19.x via
stable@kernel.org, if that's what you're asking.

Documentation/stable_kernel_rules.txt describes what patches are
appropriate for 2.6.19.x, and given that we're so close to the 2.6.19
final release, I'm working under similar rules for what I'm going to
merge into 2.6.19.
