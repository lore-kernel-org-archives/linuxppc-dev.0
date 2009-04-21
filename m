Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B1FDCDE028
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 03:33:30 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] IB/ehca: Perfomance improvment for creation of queue
	pairs
References: <200904211715.32625.ossrosch@linux.vnet.ibm.com>
Date: Tue, 21 Apr 2009 10:33:24 -0700
In-Reply-To: <200904211715.32625.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Tue, 21 Apr 2009 17:15:32 +0200")
Message-ID: <ada1vrlx66z.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stefan.roscher@qde.ibm.com, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Because of this fundamental code change we will also increment the version number.

So this is 2.6.31-targeted stuff I assume?  (Too late in the 2.6.30
cycle for "fundamental code change" of course)

 - R.
