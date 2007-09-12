Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id C81D5DDD07
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 06:22:06 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 02/12] IB/ehca: Add 1 is not longer needed because of
	firmware interface change
References: <200709111518.26276.fenkes@de.ibm.com>
	<200709111529.07935.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Sep 2007 13:21:54 -0700
In-Reply-To: <200709111529.07935.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Tue, 11 Sep 2007 15:29:07 +0200")
Message-ID: <adaodg7ocrh.fsf@cisco.com>
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

What happens if someone runs the new driver with older firmware?  Or
what if someone upgrades the firmware without updating the driver?

 - R.
