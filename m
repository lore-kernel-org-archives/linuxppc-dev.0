Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7E25DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:36:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6GKaALu054494
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:36:10 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6GKa7ue1196148
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:36:10 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6GKZoEj020968
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:35:50 +0200
In-Reply-To: <adaejj8w9t0.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 04/10] IB/ehca: use common error code mapping instead of
	specific ones
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFA7C8E574.345A8A38-ONC125731A.0071195A-C125731A.00713074@de.ibm.com>
Date: Mon, 16 Jul 2007 22:35:25 +0200
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

Roland Dreier <rdreier@cisco.com> wrote on 16.07.2007 19:14:03:

> applied, but as a further cleanup it seems that ehca2ib_return_code()
> should be moved into a .c file and moved out of line -- I think it
> would probably shrink the compiled code quite a bit, and as far as I
> can see it is never used in the data path where the function call
> overhead would matter at all.

Sounds reasonable; I'll put it in the next patch series.

Joachim
