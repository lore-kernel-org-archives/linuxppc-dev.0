Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 9B7DCDDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:08:08 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1 1/5] ehca: reworked irq handler to avoid/reduce
	missed irq events
References: <200702141740.48286.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 14 Feb 2007 14:08:03 -0800
In-Reply-To: <200702141740.48286.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Wed, 14 Feb 2007 17:40:47 +0100")
Message-ID: <adafy981jgc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, h.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks fine but this patch at least has serious whitespace
damage... please resend a fixed version.

 - R.
