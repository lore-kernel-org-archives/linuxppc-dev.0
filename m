Return-Path: <mst@dev.mellanox.co.il>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 97751DDD06
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:37:33 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so81725ugc
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 21:37:31 -0700 (PDT)
Date: Tue, 17 Jul 2007 07:37:40 +0300
From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
Message-ID: <20070717043740.GB8527@mellanox.co.il>
References: <OF2377E85C.B05BDE94-ONC125731A.006E64A7-C125731A.00714F9E@de.ibm.com>
	<ada1wf7vgfb.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ada1wf7vgfb.fsf@cisco.com>
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I still haven't seen much code using the feature or
> even any anecdotal information about the performance impact.

Here's some anecdotal evidence :)
http://lists.openfabrics.org/pipermail/general/2007-May/035758.html

-- 
MST
