Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id BE842DDF9F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 04:17:14 +1100 (EST)
Date: Mon, 5 Mar 2007 10:04:02 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Real time clock support in arch/powerpc
Message-ID: <20070305170402.GB32672@mag.az.mvista.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6216@zch01exm23.fsl.freescale.net>
	<9A1B5311-2BE0-4757-A2EB-B4E316289FD0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9A1B5311-2BE0-4757-A2EB-B4E316289FD0@kernel.crashing.org>
From: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2007 at 09:10:47AM -0600, Kumar Gala wrote:
> 
> On Mar 5, 2007, at 2:02 AM, Zang Roy-r61911 wrote:
> 
> >
> >Is there any plan to add real time clock support in arch/powerpc?
> >I can find the support in arch/ppc/syslib/todc_time.c
> 
> I thought our intent was to try and start using the drivers rtc  
> subsystem going forward.

It is.  todc is deprecated and removed from arch/powerpc.  drivers/rtc
is what we should use from now on.

Mark
