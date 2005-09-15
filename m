Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A6676829F
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2005 06:57:32 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 15 Sep 2005 22:57:09 +0200
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050915205709.GA31156@iram.es>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17193.22140.962651.122114@cargo.ozlabs.ibm.com>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 15, 2005 at 09:09:48PM +1000, Paul Mackerras wrote:
> Jon Loeliger writes:
> 
> > In the Grand Scheme of Things, removing things and making them
> > simpler seems a lofty goal. :-)   Anyone know of any pitfalls that
> > await me if I try to remove these sections, a la pmac and friends?
> 
> You'll probably get most objection from the PReP users, for whom
> getting back a few hundred kB is a big deal.  (Maybe we should just
> buy both of them a G5 or something. 8-)

Well, we have something like 20 or 25 VME machines controlling 
experiments here, some with only 16Mb of RAM. The lifetime
of these systems is often of the order of 20 years (we shall
finally get rid of our TMS9900 processors with 32kB in November,
they were bought in 1982 I believe).

So yes, I object strongly object if I don't have a way 
of removing useless PMAC code. The kernel is already very 
bloated compared with the 2.2 we started with, which was 
well below 1MB with the minimal setup: serial console, root 
on NFS, no swap, some locally modules to control the PCI<->VME 
bridge and what is behind on the VME bus. 

	Gabriel
