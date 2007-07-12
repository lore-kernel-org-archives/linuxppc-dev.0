Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 95B4FDDF8A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 03:25:32 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 00/10] IB/ehca: Multiple Event Queues, MR/MW rework,
	large page MRs, fixes
References: <200707121745.27592.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 12 Jul 2007 10:15:24 -0700
In-Reply-To: <200707121745.27592.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Thu, 12 Jul 2007 17:45:26 +0200")
Message-ID: <adawsx55ys3.fsf@cisco.com>
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

 > Note that patch 7 will introduce a few lines over 80 chars that will be
 > unindented in patch 8 - I hope that's okay with you.

That's fine -- the 80 column rule is one thing I don't worry about too
much; absurdly long lines are bad, but if a line is, say, 84 chars and
breaking it makes the code uglier, then I just leave the 84 char line.

 > [09/10] fixes a lot of checkpatch.pl warnings

Are these warnings from earlier patches in the series, or problems
that already existed in the code?  If they are coming from other
patches in the series, please just fix the earlier patches before I
merge them.

Thanks,
  Roland
