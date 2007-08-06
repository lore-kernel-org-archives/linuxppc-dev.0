Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79152DDE1C
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 15:00:21 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7653LAv300790
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:03:21 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l764xQot236958
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 14:59:26 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7650Jnt007355
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:00:19 +1000
Date: Mon, 6 Aug 2007 15:00:12 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 10/10] Bamboo zImage wrapper
Message-ID: <20070806050011.GC11051@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161711.457497000@linux.vnet.ibm.com>
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

Ok, you have a separate bamboo.c and treeboot-bamboo.c, like with
ebony.  However here, therer's only one outermost wrapper -
treeboot-bamboo.c which means there's not really any point to this
separation.

Do you know if there are Bamboo boards with old u-boot versions, or
some other bootloader which would make the separation worthwhile
later?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
