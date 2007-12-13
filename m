Return-Path: <FENKES@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86DCFDE055
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 08:35:58 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBDLZtL3493732
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 21:35:55 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBDLZtCn2924772
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 22:35:55 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBDLZsVm016514
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 22:35:55 +0100
In-Reply-To: <78C9135A3D2ECE4B8162EBDCE82CAD7702B14004@nekter>
To: "Caitlin Bestler" <Caitlin.Bestler@neterion.com>
MIME-Version: 1.0
Subject: RE: [ofa-general] Re: [ewg] Re: [PATCH] IB/ehca: Serialize HCA-related
	hCalls on POWER5
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD36374CC.9307FC29-ONC12573B0.00763BCF-C12573B0.0076A3D3@de.ibm.com>
Date: Thu, 13 Dec 2007 22:35:52 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Or Gerlitz <ogerlitz@voltaire.com>, linuxppc-dev@ozlabs.org,
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

"Caitlin Bestler" <Caitlin.Bestler@neterion.com> wrote on 13.12.2007 
22:08:34:

> To clarify, an FMR Work Request is simply posted to the SendQ like
> any other Work Request (of course the QP has to be privileged, or
> it will complete in error). An SQ Post should never block.

This would require hardware support, wouldn't it? eHCA2 doesn't have this 
kind of support, so FMR WRs are not an option here.

J.
