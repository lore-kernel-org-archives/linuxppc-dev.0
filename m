Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id CB47A67B58
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 01:27:54 +1000 (EST)
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton
	Blanchard's new hvcall interface
References: <200609221720.24191.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 08:27:49 -0700
In-Reply-To: <200609221720.24191.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's
	message of "Fri, 22 Sep 2006 17:20:23 +0200")
Message-ID: <ada7izvhqfe.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > - shca->ib_device.node_type           = RDMA_NODE_IB_CA;
 > + shca->ib_device.node_type           = IB_NODE_CA;

Did you test this at all?  I can't see how this would build against my
for-2.6.19 tree...

Please resend a patch that you know is working.

 - R.
