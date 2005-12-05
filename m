Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17299.47900.672818.773688@cargo.ozlabs.ibm.com>
Date: Mon, 5 Dec 2005 14:59:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Giuliano Pochini <pochini@denise.shiny.it>
In-Reply-To: <Pine.LNX.4.58.0512021604360.23144@denise.shiny.it>
References: <20051126113805.709ee538.pochini@shiny.it>
	<17290.26688.710369.613144@cargo.ozlabs.ibm.com>
	<1133146369.7768.170.camel@gaston>
	<Pine.LNX.4.58.0512021604360.23144@denise.shiny.it>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: CPU off power consumption
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini writes:

> Any hint on how to debug it ?  Where is the code that enables/disables the
> cpus ?  Where is the sleep loop ?

The initial sleep loop is in ROM.  A CPU that is being offlined will
enter low_cpu_die() in arch/ppc/platforms/pmac_sleep.c and will go to
sleep at the mtmsr about 40 lines into that function.

Paul.
