Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id DA212DDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 13:48:42 +1000 (EST)
To: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
References: <OF2377E85C.B05BDE94-ONC125731A.006E64A7-C125731A.00714F9E@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 16 Jul 2007 20:48:40 -0700
In-Reply-To: <OF2377E85C.B05BDE94-ONC125731A.006E64A7-C125731A.00714F9E@de.ibm.com>
	(Hoang-Nam Nguyen's message of "Mon, 16 Jul 2007 22:37:44 +0200")
Message-ID: <ada1wf7vgfb.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
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

 > No, I've no figures to provide here. The background of this dist_eqs
 > option is actually to allow us testing across all event queues
 > without to change the testcases resp consumers to use certain
 > event queue number. Thus, I should comment it as EXPERIMENTAL?

Seems like it's just development/testing code that shouldn't escape
into the wild?

 > > I think I would rather hold off on multiple EQs for this merge window
 > > and plan on having something really solid and thought-out for 2.6.24.

 > Fair enough. However why don't let us gather experience with this
 > feature now? Should we remove dist_eqs option for more consistency?

As I said I definitely think the dist_eqs switch doesn't sound like
something we want to expose to people.

With that said I still am not sure about putting the multiple EQs
feature in this release.  All the infrastructure is there to make
experimenting with it fairly painless (just the low-level driver needs
to change), and I still haven't seen much code using the feature or
even any anecdotal information about the performance impact.
