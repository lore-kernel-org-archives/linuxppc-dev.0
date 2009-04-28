Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9F08BDDFB3
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 00:13:54 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Alexander Schmidt <alexs@linux.vnet.ibm.com>
Subject: Re: [ewg] Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<adaws9dvrkp.fsf@cisco.com>
	<200904221602.29028.ossrosch@linux.vnet.ibm.com>
	<20090428150736.1ea143f0@BL3D1974.boeblingen.de.ibm.com>
Date: Tue, 28 Apr 2009 07:01:32 -0700
In-Reply-To: <20090428150736.1ea143f0@BL3D1974.boeblingen.de.ibm.com>
	(Alexander Schmidt's message of "Tue, 28 Apr 2009 15:07:36 +0200")
Message-ID: <adabpqgx4g3.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: fenkes@de.ibm.com, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > did you have a chance to take a look at the patchset and will you apply it, or
 > are there any outstanding issues we need to address?

I guess it's OK, but definitely 2.6.31 material.  I guess I'll stick it
linux-next soon.

 - R.
