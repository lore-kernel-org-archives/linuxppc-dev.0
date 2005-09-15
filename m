Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17193.61187.613745.15444@cargo.ozlabs.ibm.com>
Date: Fri, 16 Sep 2005 08:00:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20050915205709.GA31156@iram.es>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
	<20050915205709.GA31156@iram.es>
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

Gabriel Paubert writes:

> So yes, I object strongly object if I don't have a way 
> of removing useless PMAC code. The kernel is already very 
> bloated compared with the 2.2 we started with, which was 
> well below 1MB with the minimal setup: serial console, root 
> on NFS, no swap, some locally modules to control the PCI<->VME 
> bridge and what is behind on the VME bus. 

I assume you compile custom kernels for these machines, so you're
happy with using config options to remove the code you don't want?
Having the .pmac.text, .prep.text etc. sections lets us remove
unneeded code at runtime, but it sounds like that isn't actually the
issue for you (i.e. you don't have a need to run the same kernel on
both a pmac and a prep).

Paul.
