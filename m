Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84656DDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 12:03:25 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBL13niJ018606
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 20:03:49 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBL13KUE290324
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 20:03:20 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBL13KXv028202
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 20:03:20 -0500
Date: Wed, 20 Dec 2006 19:03:19 -0600
To: Anton Blanchard <anton@samba.org>
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4
	crashes... and power5 too, actually
Message-ID: <20061221010319.GE16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta>
	<20061220211931.GB16860@austin.ibm.com>
	<1166650134.6673.9.camel@localhost.localdomain>
	<20061220230342.GC16860@austin.ibm.com>
	<1166656195.6673.23.camel@localhost.localdomain>
	<20061220234647.GD16860@austin.ibm.com>
	<20061221003658.GB3048@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061221003658.GB3048@krispykreme>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 21, 2006 at 11:36:59AM +1100, Anton Blanchard wrote:
> 
> On Wed, Dec 20, 2006 at 05:46:47PM -0600, Linas Vepstas wrote:
> 
> > System assert at:  file: rtas_io_config.c  -- line: 195
> > rio_hub_num: 10
> > drawer_num: 6
> > phb_num: 3
> > buid: 7
> 
> Looks like a firmware assert. Did you pass in something dodgy to a
> config read/write op? Maybe a bad buid?

Same kernel runs fine on power5. Although it does have patches
applied, those very same patches boot fine when applied to a slightly
older kernel (2.6.19-rc4).  I haven't been messing with buids or 
pci config space (at least not intentionaly).

I'll try again with an unpatched, unmodified kernel. 

--linas
