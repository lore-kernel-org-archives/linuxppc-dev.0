Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id A5BE1DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 03:53:00 +1000 (EST)
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
References: <OF2377E85C.B05BDE94-ONC125731A.006E64A7-C125731A.00714F9E@de.ibm.com>
	<ada1wf7vgfb.fsf@cisco.com> <20070717043740.GB8527@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 17 Jul 2007 10:52:55 -0700
In-Reply-To: <20070717043740.GB8527@mellanox.co.il> (Michael S. Tsirkin's
	message of "Tue, 17 Jul 2007 07:37:40 +0300")
Message-ID: <adalkdesyrs.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
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

 > Here's some anecdotal evidence :)
 > http://lists.openfabrics.org/pipermail/general/2007-May/035758.html

Right, but then we went on to say that we probably want to use
multiple vectors to separate out multiple HCA ports rather than
send/sreceive on the same port.  And the current IPoIB implementation
of having that second CQ seems suboptimal anyway, since it seems to
leave us susceptible to the interrupt overload that NAPI was supposed
to solve.

At a higher level, I'm left wondering why nobody talked about multiple
EQs during the last months of the 2.6.22 process and now all of a
sudden it becomes urgent in the last few days of the 2.6.23 merge
window.  That's not really how I like to merge features....

 - R.
