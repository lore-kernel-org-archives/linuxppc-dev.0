Return-Path: <tjernlund@tjernlund.se>
Received: from csmtp.b-one.net (csmtp.b-one.net [195.47.247.21])
	by ozlabs.org (Postfix) with ESMTP id 5DFAC67C04
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 05:43:03 +1000 (EST)
Received: from Jocke (unknown [84.217.1.193])
	by csmtp.b-one.net (Postfix) with ESMTP id CD5641A008531
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 20:40:33 +0200 (CEST)
From: "Tjernlund" <tjernlund@tjernlund.se>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 1 Jul 2005 20:40:32 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKEEICMAA.tjernlund@tjernlund.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > The PPC32 dbcz semantics don't seem to work properly on 8xx
> > in all cases. Removing the '.S' file makes glibc fall back on
> > the .c implementation. 
> 
> Hi Jason, 
> 
> That was a quick response - thanks.
> 
> Two questions:
> 
> - Do you happen to know about details of dcbz's (mis)behaviour on 8xx? 

This is the famus dcbX bug on 8xx CPUs. 8xx dcbX instructions don't update the
DAR register when they cause a TLB Miss/Error. This bug is undocumented but
Motorola/Freescale has verified that it is there.

   Jocke (going on vacation now, won't read email for a week)
