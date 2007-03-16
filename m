Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00B40DDF07
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 06:27:10 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2GJR7PW024488
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 15:27:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2GJR6IP033640
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 13:27:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2GJR6oC014570
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 13:27:06 -0600
Subject: Re: Don't pass the stack pointer to zImage's start() function
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070316183748.GA30637@aepfle.de>
References: <20070315042904.GE14061@localhost.localdomain>
	<20070316183748.GA30637@aepfle.de>
Content-Type: text/plain
Date: Fri, 16 Mar 2007 14:26:57 -0500
Message-Id: <1174073217.16140.10.camel@zod.rchland.ibm.com>
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

On Fri, 2007-03-16 at 19:37 +0100, Olaf Hering wrote:
> On Thu, Mar 15, David Gibson wrote:
> 
> > At present, the zImage entry code passes a copy of the stack pointer
> > to the start() function.  There's no real reason for this; the only
> > thing start() does with it is print it out.  It appears to be a
> > leftover debugging hack, so, this patch removes it.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> NACK.
> It helps to determine the firmware memory layout.

How, why is that useful, and where is that ever used?

josh
