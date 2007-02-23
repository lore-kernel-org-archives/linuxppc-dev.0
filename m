Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADF86DDF30
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 09:31:08 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1NMV0Xi025462
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 17:31:00 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1NMV0xJ290522
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 17:31:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1NMV0dk003763
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 17:31:00 -0500
Date: Fri, 23 Feb 2007 16:30:59 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc64: wait for pci error state to settle down
Message-ID: <20070223223059.GM923@austin.ibm.com>
References: <20070217005117.GO923@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070217005117.GO923@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Paul,

Please let me 'nack' my own patch.

On Fri, Feb 16, 2007 at 06:51:17PM -0600, Linas Vepstas wrote:
> 
> PCI devices may be attached via a "far away" pci bus which 
> might be in the process of being reset. Wait for the
> pci bus to come back online before trying to reset the 
> pci device.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

It doesn't appear you've picked this up yet, and after further
experimentiation, I want to do this slightly differently anyway. 
I'll try a revised patch "real soon now".

--linas
