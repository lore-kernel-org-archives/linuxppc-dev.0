Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 78C0867C74
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:58:24 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k
	page mode
References: <aday7qngiuf.fsf@cisco.com>
	<OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
	<17746.52343.815568.368590@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Nov 2006 13:58:21 -0800
In-Reply-To: <17746.52343.815568.368590@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Thu, 9 Nov 2006 17:36:39 +1100")
Message-ID: <adaodrgb7uq.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > So Roland is correct in his comment about how ioremap is called.

Umm, so is this patch really needed?  Where did the patch come from --
is it needed to fix something actually seen, or was it written just
based on some theoretical understanding?

I'm confused...

 - R.
