Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 360BBDDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 10:13:55 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Change misleading error message
References: <200806061835.43802.fenkes@de.ibm.com>
	<48499C11.7030504@gmail.com> <200811251358.06729.fenkes@de.ibm.com>
Date: Tue, 25 Nov 2008 15:13:51 -0800
In-Reply-To: <200811251358.06729.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Tue, 25 Nov 2008 13:58:06 +0100")
Message-ID: <aday6z7csb4.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Alexander Schmidt <alexschm@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > The error message printed when the eHCA driver prevents memory hotplug is
 > misleading -- the user might think that hot-removing the lhca, hotplugging
 > memory, then hot-adding the lhca again will work, but it doesn't.

That's too bad... I applied this patch but out of curiousity, why
doesn't the hot-remove/hot-add work?  I would have thought that
re-registering all of memory after the hot-add would do the right thing.
