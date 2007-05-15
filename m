Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0BC2DDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 22:48:34 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4FCmMdo009087
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 08:48:22 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4FCmMnG246296
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:48:22 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4FCmMo9005327
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:48:22 -0600
Subject: Re: [PATCH 1/3] Factor zImage's 44x reset code out of ebony.c
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070515045415.544B6DDED5@ozlabs.org>
References: <20070515045415.544B6DDED5@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 May 2007 07:47:40 -0500
Message-Id: <1179233260.3084.20.camel@zod.rchland.ibm.com>
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

On Tue, 2007-05-15 at 14:54 +1000, David Gibson wrote:
> The ebony_exit() function which resets the Ebony board should in fact
> be common to most if not all 44x boards.  This patch moves the
> function out into 44x.c, renaming it, so it can be used by other 44x
> platforms.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Tested on my ebony board.  Will work nicely for 440EP as well.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
