Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92BC0DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:04:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6JF4GYo692840
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 15:04:16 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6JF48QM1560622
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 17:04:16 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6JF3qIq011774
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 17:03:52 +0200
In-Reply-To: <adalkdesyrs.fsf@cisco.com>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF00D945EC.C16B2992-ONC125731D.0052335C-C125731D.0052B490@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 19 Jul 2007 17:03:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
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

Roland Dreier <rdreier@cisco.com> wrote on 17.07.2007 19:52:55:
> At a higher level, I'm left wondering why nobody talked about multiple
> EQs during the last months of the 2.6.22 process and now all of a
> sudden it becomes urgent in the last few days of the 2.6.23 merge
> window.  That's not really how I like to merge features....
OK, let keep multiple eqs for next release with a more stable
verbs def.
For the other patch to support MR with large pages we'll resend
it (without deps on multiple eqs patch) to you soon.
Regards
Nam
