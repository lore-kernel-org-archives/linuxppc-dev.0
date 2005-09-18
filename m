Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20050915205709.GA31156@iram.es>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
	<20050915205709.GA31156@iram.es>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 11:28:35 +1000
Message-Id: <1127006916.23095.6.camel@gaston>
Mime-Version: 1.0
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


> So yes, I object strongly object if I don't have a way 
> of removing useless PMAC code. The kernel is already very 
> bloated compared with the 2.2 we started with, which was 
> well below 1MB with the minimal setup: serial console, root 
> on NFS, no swap, some locally modules to control the PCI<->VME 
> bridge and what is behind on the VME bus. 

I think we should have the ability to not build some platforms like we
have on ppc64. That would allow you to build a PReP kernel without CHRP
and PMAC code.

Ben.
