Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 11FAADDDD5
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 23:26:51 +1000 (EST)
Date: Thu, 5 Jul 2007 08:37:34 -0500
To: Sonny Rao <sonny@burdell.org>
Subject: Re: [PATCH] pseries: don't die if unknown/missing interrupt
	controller property
Message-ID: <20070705133734.GA9215@lixom.net>
References: <20070702004937.GA15712@kevlar.boston.burdell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070702004937.GA15712@kevlar.boston.burdell.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 01, 2007 at 08:49:37PM -0400, Sonny Rao wrote:
> The pseries platform does not have a default function for init_IRQ and
> does not install one if it doesn't find or doesn't recognize an
> interrupt controller in the device tree.  Currently, the kernel dies
> when it tries to call the NULL init_IRQ() function.  Clean that up.

Doesn't it make more sense to make init_IRQ() check that the pointer is
set instead? That'll work for more platforms than just pseries.


-Olof
