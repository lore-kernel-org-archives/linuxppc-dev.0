Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90A11B7D47
	for <linuxppc-dev@ozlabs.org>; Thu,  6 May 2010 08:20:07 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o45MCgio009020
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 16:12:42 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o45MJnqr125000
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 16:19:49 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o45MJlCg025734
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 16:19:48 -0600
Date: Wed, 5 May 2010 15:25:53 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
Message-ID: <20100505222553.GA6555@us.ibm.com>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-12-git-send-email-orenl@cs.columbia.edu>
	<20100505141447.fc2397f6.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100505141447.fc2397f6.randy.dunlap@oracle.com>
Cc: linux-s390@vger.kernel.org, Oren Laadan <orenl@cs.columbia.edu>,
	containers@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Matt Helsley <matthltc@us.ibm.com>, linux-api@vger.kernel.org,
	Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pavel Emelyanov <xemul@openvz.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Randy Dunlap [randy.dunlap@oracle.com] wrote:
| > +		base of the region allocated for stack. These architectures
| > +		must pass in the size of the stack-region in ->child_stack_size.
| 
| 		                             stack region
| 
| Seems unfortunate that different architectures use the fields differently.

Yes and no. The field still has a single purpose, just that some architectures
may not need it. We enforce that if unused on an architecture, the field must
be 0. It looked like the easiest way to keep the API common across
architectures.

| 
| Is this example program meant to build only on i386?

Yes. Will add a pointer to the clone*.[chS] and libeclone.a files in

	git://git.ncl.cs.columbia.edu/pub/git/user-cr.git

for other architectures (currently x86_64, ppc, s390).

Thanks for the review. Will fix the errors and repost.

Sukadev
