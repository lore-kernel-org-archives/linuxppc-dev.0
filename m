Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 478F2DDF8E
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 23:49:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l42Dnfmr004077
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 09:49:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l42DnfRN176718
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 07:49:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l42DneTG019466
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 07:49:40 -0600
Subject: Re: [PATCH] powerpc: fix spurious vectors on weird MPIC
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <1177965491.3026.47.camel@zod.rchland.ibm.com>
References: <1177965491.3026.47.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 08:45:15 -0500
Message-Id: <1178113515.3026.89.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-30 at 15:38 -0500, Josh Boyer wrote:
> The weird TSI 10x MPIC needs an EOI after getting a spurious vector.  This
> patch uses the existing MPIC_SPV_EOI flag to fix this issue.

Paul, I'd like to get this into 2.6.22 if possible.  It's needed for a
round of patches I'll be sending out soon.

thx,
josh
