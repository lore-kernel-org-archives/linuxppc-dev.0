Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7740DDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 18:31:38 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7T8VXMc139056
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 08:31:33 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7T8VXPc2285808
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 10:31:33 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7T8VWss024085
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 10:31:32 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: Re: RFC: issues concerning the next NAPI interface
Date: Wed, 29 Aug 2007 10:31:30 +0200
References: <200708281319.03903.ossthema@de.ibm.com>
	<46D51BD7.6040904@de.ibm.com>
	<20070829.012916.02298847.davem@davemloft.net>
In-Reply-To: <20070829.012916.02298847.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708291031.31923.ossthema@de.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, jchapman@katalix.com, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akepner@sgi.com, meder@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 29 August 2007 10:29, David Miller wrote:
> From: Jan-Bernd Themann <ossthema@de.ibm.com>
> Date: Wed, 29 Aug 2007 09:10:15 +0200
> 
> > In the end I want to reduce the CPU utilization. And one way
> > to do that is LRO which also works only well if there are more
> > then just a very few packets to aggregate. So at least our
> > driver (eHEA) would benefit from a mix of timer based polling
> > and plain NAPI (depending on load situations).
> > 
> > If there is no need for a generic mechanism for this kind of
> > network adapters, then we can just leave this to each device
> > driver.
> 
> No objections from me either way, if something works then
> fine.
> 
> Let's come back to this once you have a tested sample implementation
> that does what you want, ok?

Sounds good
