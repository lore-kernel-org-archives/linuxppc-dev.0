Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5644DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 04:13:19 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n29HCnTD009864
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 11:12:49 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n29HDB7j223052
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 11:13:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n29HDACp007257
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 11:13:11 -0600
Date: Mon, 9 Mar 2009 13:12:43 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Mikhail Zolotaryov <lebon@lebon.org.ua>
Subject: Re: [PATCH] powerpc 4xx: DDR0_14[REDUC] decoded incorrectly
Message-ID: <20090309171243.GA26415@zod.rchland.ibm.com>
References: <49B54210.5040709@lebon.org.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B54210.5040709@lebon.org.ua>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2009 at 06:21:36PM +0200, Mikhail Zolotaryov wrote:
> Hi,
>
> according to the PPC440EPx Embedded Processor User Manual (rev 1.14)  
> DDR0_14[REDUC] bit has the following meaning:
>
> REDUC - Enable the half data path feature of the controller
> 0 = Standard operation using full 64/72-bit memory bus
> 1 = Memory data path width is 32/40 bits
>
> However, "1" is decoded as 64 bit (8 byte), "0" - as 32 bit (4 byte) bus  
> by the kernel code. My understanding is this is not correct - patch  
> attached.

You are missing the Signed-off-by tag that is needed.

Aside from that, I'm curious if you found this just through inspection, or
if you actually had a problem because of it.  Your fix seems correct, yet
I've had no problems with my boards at all.

josh
