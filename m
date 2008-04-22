Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BA5EDE38A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 03:42:15 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3MHg9Gl001847
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:42:10 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3MHg9lp014922
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 12:42:09 -0500 (CDT)
Date: Tue, 22 Apr 2008 12:42:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: Question on MPC83xx interrupts
Message-ID: <20080422174208.GB18076@ld0162-tx32.am.freescale.net>
References: <480E1939.6000701@matrix-vision.de>
	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>
	<480E2230.2030601@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <480E2230.2030601@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 07:36:48PM +0200, Andre Schwarz wrote:
> thanks - any Idea how to figure out where the BAD comes from ?
> Is it simply an unhandled/unacked one ?

It generally happens when an interrupt is requested, and the core takes
the exception, but then the interrupt source deasserts itself.

-Scott
