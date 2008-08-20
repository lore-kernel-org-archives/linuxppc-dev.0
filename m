Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B19B3DE713
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 00:03:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KE3kh3030983
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 10:03:46 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KE3ko6217372
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 10:03:46 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KE3jpe027372
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 10:03:45 -0400
Date: Wed, 20 Aug 2008 10:03:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
Message-ID: <20080820100345.17c63ca7@zod.rchland.ibm.com>
In-Reply-To: <200808201533.22258.arnd@arndb.de>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 15:33:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 19 August 2008, Josh Boyer wrote:
> > This adds a common board file for almost all of the "simple" PowerPC 44x
> > boards that exist today.  This is intended to be a single place to add
> > support for boards that do not differ in platform support from most of the
> > evaluation boards that are used as reference platforms.  Boards that have
> > specific requirements or custom hardware setup should still have their own
> > board.c file.
> 
> The code looks correct, but since this is going to be example code
> that may get copied into other platforms, I would take extra care
> for coding style:

Fair enough.  Your comments all make sense to me.  I'll fixup things
and resend this one.

josh
