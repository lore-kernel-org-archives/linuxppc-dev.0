Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13DBCDDF38
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 22:44:41 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4TCiYlQ126216
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 12:44:34 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4TCiYcH2625706
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:44:34 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4TCiYTB006415
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:44:34 +0200
In-Reply-To: <adalkfe6rxk.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Refactor "maybe missed event" code
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFA7B951E3.8AFF22C4-ONC12572EA.0045F4E8-C12572EA.00461997@de.ibm.com>
Date: Tue, 29 May 2007 14:44:32 +0200
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

Roland Dreier <rdreier@cisco.com> wrote on 24.05.2007 19:40:39:

> This isn't fixing anything is it?  I think it's 2.6.23 material;
> correct me if I'm wrong.

Right, it doesn't fix things, just coalesces some code.

Joachim
