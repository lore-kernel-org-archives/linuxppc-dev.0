Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5290CDE010
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:46:48 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3NDgweb024101
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:42:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3NDkgCD182110
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:46:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3NDisYJ023925
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:44:55 -0400
Date: Thu, 23 Apr 2009 09:45:38 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH] PPC440EPx SDRAM width
Message-ID: <20090423134538.GB3825@zod.rchland.ibm.com>
References: <49F06ECC.7030904@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F06ECC.7030904@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 09:36:12AM -0400, Steven A. Falco wrote:
>There is an error in the way ibm4xx_denali_fixup_memsize calculates
>memory size.  When testing the DDR_REDUC bit, the polarity is
>backwards.  A "1" implies 32-bit wide memory while a "0" implies
>64-bit wide memory.
>
>For a 32-bit wide system, this bug causes twice the memory to be
>reported, leading to boot failure.
>
>Signed-off-by: Steven A. Falco <sfalco@harris.com>

So we had a previous patch for this, and a very long discussion on what the
right solution was.  Either we never came to a resolution, or I have just
forgotten what it was.

Stefan, Valentine, do either of you remember?  IIRC, it wasn't something that
effected Sequoia or Rainier, but it could (and obviously does) effect custom
boards.  I don't remember what we agreed on for the proper fix.

josh
