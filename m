Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA105DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 00:24:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALDOFHk031970
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:24:15 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALDOFSQ088106
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:24:15 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALDOEYs016637
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:24:15 -0700
Date: Wed, 21 Nov 2007 07:24:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 14/14] powerpc: Add PCI to Walnut platform
Message-ID: <20071121072413.12df4d92@weaponx>
In-Reply-To: <20071121061722.2FCB7DDE45@ozlabs.org>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061722.2FCB7DDE45@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Nov 2007 17:16:32 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This wires up the 4xx PCI support & device-tree bits for the
> 405GP based Walnut platform.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This one is untested, haven't had time to dig my walnut and put it
> back into working condition. Josh, can you verify that IRQs are
> working (routing is correct ?) Thanks !

Yep, I'll try it out early next week.

josh
