Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id CF71C67E03
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 03:40:58 +1100 (EST)
To: Christoph Raisch <RAISCH@de.ibm.com>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct
	page mapping in 64k page mode
References: <OFEBD51474.F7DD1031-ONC1257225.0032352E-C1257225.005B569D@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 08:40:48 -0800
In-Reply-To: <OFEBD51474.F7DD1031-ONC1257225.0032352E-C1257225.005B569D@de.ibm.com>
	(Christoph Raisch's message of "Mon, 13 Nov 2006 17:40:52 +0100")
Message-ID: <adabqnb5mgf.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, openib-general-bounces@openib.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > So Roland, feel free to ignore that line where we do the calculation.

OK, ignore the email I just sent.  I'll drop the patch.

thanks
