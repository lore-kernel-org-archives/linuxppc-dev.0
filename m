Return-Path: <rolandd@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 05B7767B57
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 06:19:28 +1000 (EST)
Subject: [PATCH 00/16] IB/ehca: introduction
In-Reply-To: 
Date: Thu, 17 Aug 2006 13:09:27 -0700
Message-Id: <2006817139.43eVtRoa2IK8yOPl@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
From: Roland Dreier <rolandd@cisco.com>
Cc: RAISCH@de.ibm.com, HNGUYEN@de.ibm.com, MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a series of patches (split up rather arbitrarily to avoid
too-big emails) which adds a driver for the IBM eHCA InfiniBand
adapter.  The driver has been around for a while, and my feeling is
that it is good enough to merge, even though it could certainly use
some cleaning up.  However, my feeling is that we don't need to wait
for this driver to be perfect before merging it, and that it would be
better for everyone if it gets into mainline (eg coordination with
Anton's hcall cleanup becomes simpler).

Please review and comment, and do let me know if you disagree with my
decision to merge this for 2.6.19.  (BTW, just to be clear -- I'll
collapse this driver into a single git commit with full changelog and
Signed-off-by: lines before actually merging it -- the bare patches
are just for review)

The driver is also available in git for your reviewing pleasure at

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ehca

The developers of the driver are cc'ed on this thread and should
respond to any comments.

Thanks,
  Roland
