Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id A61E2DE02C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 03:14:06 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 04/10] IB/ehca: use common error code mapping instead of
	specific ones
References: <200707121745.27592.fenkes@de.ibm.com>
	<200707121749.03556.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 16 Jul 2007 10:14:03 -0700
In-Reply-To: <200707121749.03556.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Thu, 12 Jul 2007 17:49:02 +0200")
Message-ID: <adaejj8w9t0.fsf@cisco.com>
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

 > @@ -161,8 +161,11 @@ static inline int ehca2ib_return_code(u64 ehca_rc)

applied, but as a further cleanup it seems that ehca2ib_return_code()
should be moved into a .c file and moved out of line -- I think it
would probably shrink the compiled code quite a bit, and as far as I
can see it is never used in the data path where the function call
overhead would matter at all.
