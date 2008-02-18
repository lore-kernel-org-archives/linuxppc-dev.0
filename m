Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5EB84DDEBD
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 23:43:54 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1ICjm2q026783
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 07:45:48 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1IChpbm239674
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 07:43:51 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1IChpgf002571
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 07:43:51 -0500
Date: Mon, 18 Feb 2008 06:43:11 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: "make ARCH=ppc defconfig" fails looking for common_defconfig
Message-ID: <20080218064311.737307a6@zod.rchland.ibm.com>
In-Reply-To: <alpine.LFD.1.00.0802180430100.10518@localhost.localdomain>
References: <alpine.LFD.1.00.0802180430100.10518@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Feb 2008 04:32:24 -0500 (EST)
"Robert P. J. Day" <rpjday@crashcourse.ca> wrote:

> 
>   (AIUI, the entire ppc/ architecture is going away, yes?  which means
> i probably shouldn't care about any errors within.  is that correct?
> even so, build errors should probably still be avoided for now.)

Yes, it's going away.  There's really no longer support for anything
"common" in it now anyway.  CHRP, POWER3 and POWER4 have been removed.
So have 83xx and 85xx.

Just let it go.

josh
