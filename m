Return-Path: <FENKES@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37B21DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 21:26:17 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6ABQCoO303118
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:26:12 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6ABQCfa2134140
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 13:26:12 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6ABQCZ7004898
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 13:26:12 +0200
In-Reply-To: <adazm25w998.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 06/13] IB/ehca: Set SEND_GRH flag for all non-LL UD QPs on
	eHCA2
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF42327D02.A1FE96AF-ONC1257314.003E9788-C1257314.003EE7E8@de.ibm.com>
Date: Tue, 10 Jul 2007 13:26:10 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: LKML <linux-kernel@vger.kernel.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 09.07.2007 23:35:31:

> Out of curiousity, does this mean that a GRH will be sent on all UD
> messages (for non-LL QPs)?

No - the bit instructs the hardware to fetch the GRH parts of the QP 
context.
The GRH will only be used if the WQE says so.

Joachim
