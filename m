Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 4CEF6DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 02:17:30 +1000 (EST)
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [ofa-general] [PATCH 7/7] IB/ehca: Prevent overwriting QP init
	attributes given by caller
References: <200708082044.38247.ossrosch@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Aug 2007 09:17:22 -0700
In-Reply-To: <200708082044.38247.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Wed, 8 Aug 2007 20:44:37 +0200")
Message-ID: <adatzqz1mjx.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "\"Hoang-Nam Nguyen\" @dyn-9-152-249-53"
	<Hoang-Nam.Nguyen@d01av04.pok.ibm.com>, linuxppc-dev@ozlabs.org,
	fenkes@de.ibm.com, linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't understand this patch.  <rdma/ib_verbs.h> says this about
ib_create_qp():

 * @qp_init_attr: A list of initial attributes required to create the
 *   QP.  If QP creation succeeds, then the attributes are updated to
 *   the actual capabilities of the created QP.

So it seems the current code is actually correct and your patch breaks
it??
