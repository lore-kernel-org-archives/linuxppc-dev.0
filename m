Return-Path: <FENKES@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF422DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 18:28:00 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6D8Ruge146392
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 08:27:56 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6D8Qe0F1601554
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 10:26:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6D8Qenq022831
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 10:26:40 +0200
In-Reply-To: <adawsx55ys3.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/10] IB/ehca: Multiple Event Queues, MR/MW rework,
	large page MRs, fixes
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFEE70CCDD.88537E20-ONC1257317.002E2CF5-C1257317.002E786F@de.ibm.com>
Date: Fri, 13 Jul 2007 10:26:39 +0200
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

>  > [09/10] fixes a lot of checkpatch.pl warnings
> 
> Are these warnings from earlier patches in the series, or problems
> that already existed in the code?  If they are coming from other
> patches in the series, please just fix the earlier patches before I
> merge them.

Nam did a diff -Nurp empty_dir ehca | checkpatch.pl and fixed all the
existing problems in the code. That's why this is such a big hunk -
we've been doing the pointer-typecast thing wrong for a long time,
for example.

Joachim
