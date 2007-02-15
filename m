Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id AD54EDDD08
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:50:23 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1 4/5] ehca: replace yield() by
	wait_for_completion()
References: <200702141741.35444.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 14 Feb 2007 16:50:06 -0800
In-Reply-To: <200702141741.35444.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Wed, 14 Feb 2007 17:41:35 +0100")
Message-ID: <adahctow8g1.fsf@cisco.com>
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

I agree with Christoph -- the use of wait_for_completion() in a loop
makes no sense.  When you send a new copy of this patch without
whitespace damage, please fix that up too...
