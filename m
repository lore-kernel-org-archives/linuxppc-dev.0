Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 01FC8DDF40
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:02:43 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [ewg] [PATCH] IB/ehca: Protect QP against destroying until all
	async events for it are handled.
References: <200805071319.37164.ossrosch@linux.vnet.ibm.com>
	<adahcdaw2oc.fsf@cisco.com>
	<200805071800.15595.ossrosch@linux.vnet.ibm.com>
Date: Wed, 07 May 2008 11:02:40 -0700
In-Reply-To: <200805071800.15595.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Wed, 7 May 2008 18:00:14 +0200")
Message-ID: <adar6ceuh4v.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, raisch@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > I agree, that's why I posted the driver fix first.

Glad we agree :)

I thought about it a little more and really convinced myself that there
is no good way for generic code to handle this race.

 > So, will you apply it next?

Yes, will apply it shortly.

 - R.
