Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 74C5F67C7F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 03:47:57 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address
	to determine pending work requests
References: <200611202354.13030.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 21 Nov 2006 08:47:52 -0800
In-Reply-To: <200611202354.13030.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Mon, 20 Nov 2006 23:54:12 +0100")
Message-ID: <adaslgcg30n.fsf@cisco.com>
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

Umm, it's really late to merge things for 2.6.19.  How severe is this
bug?  Why has it not been found until now if it causing crashes?

 - R.
