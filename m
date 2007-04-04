Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 23310DDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 14:07:15 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Allow drivers to map individual 4k pages to userspace
References: <17938.14674.621036.256587@cargo.ozlabs.ibm.com>
	<adar6r0dg0q.fsf@cisco.com>
	<1175657025.30879.45.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 03 Apr 2007 21:07:12 -0700
In-Reply-To: <1175657025.30879.45.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Wed, 04 Apr 2007 13:23:45 +1000")
Message-ID: <adamz1odbpr.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > It's somewhat architected. I doubt there will ever be a processor that
 > can have an eHCA and doesn't support that trick. The thing is, eHCA is
 > platform specific, so the remap_4k_pfn would have to be called by driver
 > specific code, but that's not a problem since that driver will only ever
 > be used on those platforms that support that call.

If I'm going off on something irrelevant, just tell me.  But is there
a chance that you would want to build a kernel that can boot on both a
platform that has eHCA, and also on some other platform that cannot
support remap_4k_pfn?  If so does this approach cause problems?

 - R.
