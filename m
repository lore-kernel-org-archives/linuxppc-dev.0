Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0FD3DDFDD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 13:51:44 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l773sHnU3133498
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:54:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l773ocEn259074
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:50:38 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l773pWYU021350
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:51:32 +1000
Date: Tue, 7 Aug 2007 13:04:46 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 10/10] Bamboo zImage wrapper
Message-ID: <20070807030446.GB15619@localhost.localdomain>
References: <20070803161711.457497000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070803161711.457497000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 11:09:10AM -0500, Josh Boyer wrote:
> Add a bootwrapper for the AMCC 440EP Bamboo Eval board.  This also adds a
> common fixup_clock function for all 440EP(x) chips.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
