Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 4ADD6DDEC4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 08:14:11 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.20 2/2] ehca: ehca_irq.c: fix mismatched spin_unlock
	in irq handler
References: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
	<200701201620.16097.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 22 Jan 2007 13:14:06 -0800
In-Reply-To: <200701201620.16097.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Sat, 20 Jan 2007 16:20:15 +0100")
Message-ID: <adaps96n4rl.fsf@cisco.com>
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

Thanks, queued for 2.6.20 (although I left the line a little longer).

I think the right thing to do is restructure this function so you
don't have lines starting 6 tab stops to the right.

 - R.
