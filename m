Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6CB6CDDF0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 01:30:16 +1000 (EST)
Date: Thu, 7 Jun 2007 10:36:50 -0500
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8349ea Random Device Generator driver
Message-ID: <20070607153650.GC2851@lixom.net>
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
	<46673009.6000109@freescale.com> <20070606222456.GA28225@lixom.net>
	<466735F3.7040504@freescale.com> <20070606235440.GA28400@lixom.net>
	<466814E7.3090101@freescale.com> <20070607152041.GA2851@lixom.net>
	<46682233.7060601@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46682233.7060601@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 10:20:19AM -0500, Timur Tabi wrote:

> Ok, I understand that, too.  I just don't understand absolutist statements like "you can 
> never assign a __le16 type to any other integer type" when our code is full of example of 
> doing just that.

Because you're doing it wrong, and your code is broken. Try running
it through sparse and watch the spew. I get 68 sparse warnings on
arch/powerpc/sysdev/*

You have some work to do!


-Olof
