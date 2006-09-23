Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id E061C67B85
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 11:21:50 +1000 (EST)
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton
	Blanchard's new hvcall interface
References: <200609222200.12722.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 18:21:47 -0700
In-Reply-To: <200609222200.12722.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's
	message of "Fri, 22 Sep 2006 22:00:12 +0200")
Message-ID: <adahcyzfkd0.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, linuxppc-dev@ozlabs.org,
	Christoph.Raisch/Germany/IBM@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks, I rolled this up in the ehca patch in my tree.

Anyway both Paul and I merged with Linus today, so the hcall cleanup
and ehca are both upstream.  It would be great if you could do a quick
check to make sure that ehca works in Linus's current git tree.

Thanks,
  Roland
