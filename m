Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 3AA43DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:11:59 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 00/13] IB/ehca: eHCA2 enablement & some fixes
References: <200707091502.22407.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 09 Jul 2007 15:11:42 -0700
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Mon, 9 Jul 2007 15:02:21 +0200")
Message-ID: <adak5t9w7kx.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
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

thanks, I applied these for 2.6.23 and fixed a bunch of minor things
that scripts/checkpatch.pl complained about (since I was in a mood to
do mindless things).  In the future please run that yourself and clean
up the obvious things.  I generally don't worry about the 80 column
stuff, but it will catch most whitespace problems and tell you that
foo(x,y) should be foo(x, y) etc.  So you don't have to completely
silence the script but at least take a look at the output.
