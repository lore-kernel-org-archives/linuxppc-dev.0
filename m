Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00BD2DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:41:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAKFeskI004938
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:40:54 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAKFfAYE160250
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:41:10 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAKGfHZT022813
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 11:41:18 -0500
Date: Thu, 20 Nov 2008 10:40:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081120104052.3c2383cf@zod.rchland.ibm.com>
In-Reply-To: <20081120152054.GO24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de>
	<20081120141345.GA2410@yoda.jdub.homelinux.org>
	<20081120152054.GO24487@codiert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Nov 2008 16:20:54 +0100
Benjamin Krill <ben@codiert.org> wrote:

> Hi Josh,
> 
> >What does 'NWP' stand for, and how is it different from a regular serial
> >port?  Also, what platforms can this device be found on currently?
> >
> >Some of that should be included in the changelog, but I'm curious as well
> >too.
> 
> NWP stands for network processor and it is part of the QPACE - Quantum
> Chromodynamics Parallel Computing on the Cell Broadband Engine
> project [1]. The implementation is a lightweight uart implementation
> with the focus to consume as little resources as possible and it is
> connected to a DCR bus.

Neat.  Thanks.  We should include that in the changelog.

josh
