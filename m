Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7ACEDDE22
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 12:35:33 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1I1ZR7J009607
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 20:35:27 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1I1ZRCp540298
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 18:35:27 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1I1ZRkT014671
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 18:35:27 -0700
Date: Sat, 17 Feb 2007 19:40:43 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC 3/3] zImage: Exception vector support
Message-ID: <20070218014043.GD1038@crusty.rchland.ibm.com>
References: <45D7A914.4040000@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D7A914.4040000@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
> platforms which have entry points in the vector table.  This implements
> SMP entry via the system reset vector.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> ---
>  arch/powerpc/boot/head.S       |   96 +++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/zImage.lds.S |    2 

This one seems pretty PS3 specific, and there's no makefile entry to actually
compile it...  Could we name it head_ps3.S or something similar?

Or am I misunderstanding the code and it's really generic to most SMP
machines (which would make a case to arguably call it head_smp.S).

josh
