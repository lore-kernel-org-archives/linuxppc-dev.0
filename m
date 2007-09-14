Return-Path: <FENKES@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 16981DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 23:48:07 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8EDm3LN062852
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:48:03 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8EDm2Ub2166842
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:48:02 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8EDm2sS016487
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:48:02 +0200
In-Reply-To: <adaodg7ocrh.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 02/12] IB/ehca: Add 1 is not longer needed because of
	firmware interface change
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF628247C3.FB0AFE13-ONC1257355.005E8356-C1257356.004BCE85@de.ibm.com>
Date: Fri, 14 Sep 2007 15:48:00 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
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

Roland Dreier <rdreier@cisco.com> wrote on 12.09.2007 22:21:54:

> What happens if someone runs the new driver with older firmware?  Or
> what if someone upgrades the firmware without updating the driver?

Thanks for pointing our noses to this. Your comment triggered some further 
internal discussions about the meaning of the values for the current 
system implementation. We'll think this one over again and repost the 
final solution in time for 2.6.24-rc1.

If the rest of this patchset is okay with you, could you apply it and 
leave out this one patch? The patchset will apply cleanly without it.

Thanks,
  Joachim
