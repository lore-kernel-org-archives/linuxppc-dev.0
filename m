Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1B9CDE029
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:03:01 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l3Q0M2lQ298738
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:22:02 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3Q06VLO105950
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:06:31 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3Q02xwv007524
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:02:59 +1000
Date: Wed, 25 Apr 2007 10:51:36 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: powerpc: Abolish PHYS_FMT macro from arch/powerpc
Message-ID: <20070425005136.GA12893@localhost.localdomain>
References: <20070424050518.GC30007@localhost.localdomain>
	<20070424170052.GW31947@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070424170052.GW31947@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, 2007 at 12:00:52PM -0500, Linas Vepstas wrote:
> On Tue, Apr 24, 2007 at 03:05:18PM +1000, David Gibson wrote:
> > 32-bit powerpc systems define a macro, PHYS_FMT, giving a printf
> 
> Your patch removed the use of the macro, but does not remove the definition
> of the macro.

Yes, that's because the definition is in asm-ppc, and it's still used
in asm-ppc.  My upcoming patches which start to remove arch/powerpc's
final dependencies on asm-ppc won't be moving PHYS_FMT across.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
