Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 77E44DE03E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 04:35:52 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Alexander Schmidt <alexs@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5 try2] ib/ehca: discard double CQE for one WR
References: <200808121546.31057.alexs@linux.vnet.ibm.com>
Date: Tue, 12 Aug 2008 11:35:48 -0700
In-Reply-To: <200808121546.31057.alexs@linux.vnet.ibm.com> (Alexander
	Schmidt's message of "Tue, 12 Aug 2008 15:46:30 +0200")
Message-ID: <adasktaw06z.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Fenkes <fenkes@de.ibm.com>, of-ewg <ewg@lists.openfabrics.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	of-general <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks, applied all 5.
