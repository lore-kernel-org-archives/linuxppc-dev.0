Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id B2501DDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:35:40 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 06/13] IB/ehca: Set SEND_GRH flag for all non-LL UD QPs on
	eHCA2
References: <200707091502.22407.fenkes@de.ibm.com>
	<200707091527.14272.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 09 Jul 2007 14:35:31 -0700
In-Reply-To: <200707091527.14272.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Mon, 9 Jul 2007 15:27:13 +0200")
Message-ID: <adazm25w998.fsf@cisco.com>
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

Out of curiousity, does this mean that a GRH will be sent on all UD
messages (for non-LL QPs)?

What decides if a QP is LL or not?

 - R.
