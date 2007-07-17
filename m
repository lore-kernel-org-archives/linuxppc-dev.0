Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9FFAFDDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 16:30:39 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6H6UY4W157282
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:30:34 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6H6UQJ32117876
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:30:34 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6H6U93F023749
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:30:09 +0200
In-Reply-To: <adatzs3u1sa.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] IB/ehca: Support large page MRs
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF38142F5F.0D12E609-ONC125731B.00239A1F-C125731B.0023C7C0@de.ibm.com>
Date: Tue, 17 Jul 2007 08:29:54 +0200
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

Roland Dreier <rdreier@cisco.com> wrote on 17.07.2007 05:50:13:

>  > > Why the module parameter?  Is there any reason a user would want to
>  > > turn this off?  Or conversely, why is it off by default?
>  > 
>  > We're pretty confident this new feature works, but as with all new 
and 
>  > possibly experimental features, there are chances it might explode 
your 
>  > machine when activated. So, like with the scaling code, we want the 
user 
>  > to make the conscious decision of using this code instead of 
activating it 
>  > by default.
> 
> OK, I guess.  So can we expect to, say, change the default to turning
> it on for 2.6.24 and remove the option entirely (so it's always on) in
> 2.6.25?

Deal.

Joachim
