Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B42BDDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 04:37:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EIbCP2026543
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 14:37:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EIbCFJ413680
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 12:37:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EIbB3w018016
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 12:37:11 -0600
Date: Fri, 14 Sep 2007 13:37:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from for-2.6.24
Message-ID: <20070914133710.541f0dbb@weaponx.rchland.ibm.com>
In-Reply-To: <16B381A2-66F5-4E7A-BDDC-6E536296C933@kernel.crashing.org>
References: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
	<AC7B9A70-5050-4191-A20E-B92686B675D4@kernel.crashing.org>
	<20070914122510.6dffb747@weaponx.rchland.ibm.com>
	<16B381A2-66F5-4E7A-BDDC-6E536296C933@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2007 13:24:17 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> >>> Roy Zang (1):
> >>>       [POWERPC] Update mpc7448hpc2 device tree to be compatible for
> >>> tsi109 chip
> >>
> >> Dropped for now.  I doubt we want this based on Segher's comments.
> >> (pretty sure its a ts108 on the hpc2 board).
> >
> > It is a tsi108 on hpc2.  Holly has tsi109.  From a Linux perspective,
> > there is no difference.  And the comment Segher made on the list was
> > "Looks good, thanks!"  So what other comment are you talking about?
> 
> I think that was to the .dts clean ups.  The patch from Roy wasn't  
> part of that.
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042499.html

Nope, on the original patch:

http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039289.html

Guess Segher changed his mind :)

> But, I think segher is right in saying we should have tsi109 props if  
> the HW is actually tsi108.

Yeah, that's probably true.

josh
