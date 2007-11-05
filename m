Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37C65DDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 08:17:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA5LH4eN010559
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 16:17:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA5LH0j3110770
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 14:17:00 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA5LH0oU013370
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 14:17:00 -0700
Date: Mon, 5 Nov 2007 15:16:59 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: mmap question on ppc440
Message-ID: <20071105151659.3ea601e4@weaponx>
In-Reply-To: <472F8503.2080705@harris.com>
References: <472F8503.2080705@harris.com>
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

On Mon, 05 Nov 2007 16:02:59 -0500
"Steven A. Falco" <sfalco@harris.com> wrote:

> I am attempting to access the CPLD on the AMCC Sequoia board from 
> user-land.  I open /dev/mem, and mmap it, then try to access the 
> resulting pointer.  That works fine when accessing physical addresses 
> that correspond to RAM, but as soon as I try to access the CPLD at 
> physical address 0xc0000000, I get an infinite machine check.

That's because the CPLD is actually at physical address 0x1C0000000.
Yay for 36-bit physical addresses.

josh
