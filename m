Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45093DDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:02:43 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBK12fDs025376
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 20:02:41 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBK12fkd233680
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 20:02:41 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBK12eeq009205
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 20:02:40 -0500
Date: Tue, 19 Dec 2006 19:02:39 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061220010239.GM5506@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166575984.19254.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1166575984.19254.101.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 20, 2006 at 11:53:04AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2006-12-19 at 18:46 -0600, Linas Vepstas wrote:
> > Hi Ben, 
> > 
> > Per xchat, here's the update. I'm guessing I'm using a broken
> > compiler, as per chain of evidence below ... 
> > 
> > I noticed that linux-2.6.20-rc1-git6 crashes on power4
> > in SMP mode:
> 
> Have you tried a different gcc to confirm ?

tommorrow .. 
