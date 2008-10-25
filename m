Return-Path: <pbadari@gmail.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2A3CDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 11:01:46 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9ONwQm0023170
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 19:58:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9P01h83088598
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 20:01:43 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9P01dF9021215
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 20:01:39 -0400
Subject: Re: 2.6.27-git7 compile error (ppc)
From: Badari Pulavarty <pbadari@gmail.com>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <49025275.4050102@nortel.com>
References: <1224265634.15582.3.camel@badari-desktop>
	<1224267073.15582.8.camel@badari-desktop>
	<FEFFA236-AA3B-49F1-AED2-E42950B87BD7@kernel.crashing.org>
	<200810250054.05849.rjw@sisk.pl>  <49025275.4050102@nortel.com>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 17:02:29 -0700
Message-Id: <1224892949.16003.30.camel@badari-desktop>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-24 at 16:55 -0600, Chris Friesen wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 17 of October 2008, Kumar Gala wrote:
> 
> >> I've got a patch that seems to address this for me building w/ 
> >> CONFIG_RELOCATABLE on ppc32/85xx.
> > 
> > Has that been fixed in 2.6.27 and/or current mainline?
> 
> I think CONFIG_RELOCATABLE was introduced post 2.6.27, so shouldn't be a 
> problem in that version.
> 
> Chris

Not quite true. CONFIG_RELOCATABLE is present in 2.6.27, but the changes
to types.h happend post 2.6.27 - so there is no problem with 2.6.27.

2.6.27-git11 compiles fine.

Thanks,
Badari
