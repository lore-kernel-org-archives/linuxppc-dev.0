Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDE54DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 18:57:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7V8vWOS285086
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:57:32 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7V8vVQH2134020
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 10:57:31 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7V8vVik008527
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 10:57:31 +0200
In-Reply-To: <20070830212816.GA4263@austin.ibm.com>
To: linas@austin.ibm.com (Linas Vepstas)
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD83AA06B.BECCA59D-ONC1257348.0030CA33-C1257348.003132C0@de.ibm.com>
Date: Fri, 31 Aug 2007 10:57:28 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

linas@austin.ibm.com (Linas Vepstas) wrote on 30.08.2007 23:28:16:

> On Thu, Aug 30, 2007 at 04:00:56PM +0200, Joachim Fenkes wrote:
> > 
> > Plus, I rather like using 
> > the full_name since it also contains a descriptive name as opposed to 
> > being just nondescript numbers, helping the layman (ie user) to make 
sense 
> > out of a dev_id.
>
> [...]
> Location codes are nice. 

I sure agree with you. Still, they're not unique, so we can't use them as 
bus_id. That's why we're having this discussion at all.

What I meant was "I like using the full_name over using the device address 
/ DRC index / you-name-it only". Location code is right out.

Cheers,
  Joachim
