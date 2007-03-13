Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5911ADDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 23:14:51 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2DCEmor015888
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:14:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2DCEkq6052670
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 06:14:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2DCEjqH014692
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 06:14:46 -0600
Subject: Re: [PATCH 02/19] bootwrapper: Set -msoft-float and assembler
	target options.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20070313053258.GB27618@mag.az.mvista.com>
References: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
	<17910.4629.587851.80369@cargo.ozlabs.ibm.com>
	<20070313053258.GB27618@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 07:14:45 -0500
Message-Id: <1173788085.3953.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-12 at 22:32 -0700, Mark A. Greer wrote:
> On Tue, Mar 13, 2007 at 01:53:09PM +1100, Paul Mackerras wrote:
> 
> > We
> > should also consider whether the command-line editing is generally
> > useful, or not, and whether the function to do it should be made more
> > generic.
> 
> IMHO, it is very useful if you have fw that doesn't update the dtb for
> you (i.e., OF and u-boot).  Don't know if it makes sense for OF and/or
> u-boot.

I've found the command-line editing very useful.  Especially during
board bringup.  I'd very much like it if this stayed.

josh
