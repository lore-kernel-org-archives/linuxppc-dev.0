Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 3AE52DDEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 02:29:22 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 3/3] IB/ehca: Make sure user pages are from hugetlb before
	using MR large pages
References: <200709131814.13937.fenkes@de.ibm.com>
	<200709131816.21162.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 20 Sep 2007 09:29:12 -0700
In-Reply-To: <200709131816.21162.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Thu, 13 Sep 2007 18:16:20 +0200")
Message-ID: <ada6425gv1j.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
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

thanks, applied this and the umem patch...
