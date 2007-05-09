Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82B53DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 20:36:58 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49Aaoja020762
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 06:36:50 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49Aanrs521718
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 06:36:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49Aang3026389
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 06:36:49 -0400
Subject: Re: Remove flash maps for no longer supported 405LP boards
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070509071331.GA16163@localhost.localdomain>
References: <20070509071331.GA16163@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 05:31:00 -0500
Message-Id: <1178706660.3453.65.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-09 at 17:13 +1000, David Gibson wrote:
> drivers/mtd/maps includes flash maps for the Beech and Arctic PowerPC
> 405LP based boards.  However, the 405LP was discontinued before any
> quantity were distributed and those boards no longer have kernel
> support in general.  Therefore, this patch removes this obsolete code.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
