Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B73DDDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 18:23:35 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6L8NTx6309236
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 08:23:29 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6L8NLFt2179254
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 10:23:29 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6L8N4AQ029988
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 10:23:05 +0200
In-Reply-To: <adabqe67632.fsf@cisco.com>
Subject: Re: [ofa-general] [PATCH 1/5] ehca: Supports large page MRs
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OFDBEFA17C.9FE35C61-ONC125731F.002DE742-C125731F.002E0843@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Sat, 21 Jul 2007 10:22:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	general-bounces@lists.openfabrics.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland!
> I applied this, but I agree with checkpatch.pl:
>
>  > WARNING: externs should be avoided in .c files
>  > #227: FILE: drivers/infiniband/hw/ehca/ehca_mrmw.c:67:
>  > +extern int ehca_mr_largepage;
>  >
>  > WARNING: externs should be avoided in .c files
>  > #949: FILE: drivers/infiniband/hw/ehca/hcp_if.c:753:
>  > +   extern int ehca_debug_level;
>
> if you need to use a variable in more than one .c file, put the extern
> declaration in a common header that's included everywhere you use the
> variable, including the .c file that it is defined in.  That way the
> compiler can see if you get confused about the type of the variable.
That's true.
> When you get a chance, please post a follow-on patch to fix this.
Sure thing. Will do that for rc2.
Thanks!
Nam
