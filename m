Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B96EDDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 20:04:51 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id mAB945wW259754
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 09:04:05 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mAB945YS3244184
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 10:04:05 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mAB944DS027719
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 10:04:05 +0100
In-Reply-To: <adaod0nqpx4.fsf@cisco.com>
References: <200806061835.43802.fenkes@de.ibm.com>	<48499C11.7030504@gmail.com>
	<200811071742.51867.fenkes@de.ibm.com> <adaod0nqpx4.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Fix suppression of port activation events
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFA167ACE2.B60DCF5C-ONC12574FE.00319074-C12574FE.0031CE5F@de.ibm.com>
Date: Tue, 11 Nov 2008 10:04:04 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Alexander Schmidt1 <ALEXSCHM@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 10.11.2008 21:36:23:

>  > A previous fix introduced a regression where port activation events 
were
>  > dropped unconditionally if port autodetection was not enabled. Fixed.
> 
> Is this a fix to "IB/ehca: Remove reference to special QP in case of
> port activation failure"?  Because if so I can roll it into that patch,
> since Linus hasn't pulled it yet.

Yes, that would be splendid, thank you!

Cheers,
  Joachim
