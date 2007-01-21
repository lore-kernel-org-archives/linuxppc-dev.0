Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 5833ADDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 09:06:13 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.20 1/2] ehca: ehca_cq.c: fix unproper use of yield
	within spinlock context
References: <200701192250.10765.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 21 Jan 2007 14:06:09 -0800
In-Reply-To: <200701192250.10765.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Fri, 19 Jan 2007 22:50:10 +0100")
Message-ID: <ada4pqkrq5q.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, raisch@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Very minor but

 > Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>

should be

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>

(':' after the "-by")

Anyway, queued for 2.6.20, thanks.

 - R.
