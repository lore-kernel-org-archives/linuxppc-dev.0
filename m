Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 603EB67C00
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 06:31:40 +1000 (EST)
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
Subject: Re: [openib-general] [PATCH 00/16] IB/ehca: introduction
References: <2006817139.43eVtRoa2IK8yOPl@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 17 Aug 2006 13:31:37 -0700
In-Reply-To: <2006817139.43eVtRoa2IK8yOPl@cisco.com> (Roland Dreier's message
	of "Thu, 17 Aug 2006 13:09:27 -0700")
Message-ID: <adasljv85p2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry-- my patchbombing script blew up in the middle, and I didn't
restart quite correctly.  But I'm pretty sure all 16 patches did make
it out, although the numbering is screwy.  The correct series is:

    01/16, 02/16, 00/13, 01/13, ..., 13/13

I'm not going to spam everybody and resend to all the lists, but I'm
happy to resend privately to anyone who asks, or you can clone the
git tree to get the series

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ehca

Thanks,
  Roland
