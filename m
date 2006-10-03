Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3A8C67BAC
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 21:52:55 +1000 (EST)
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20061003012241.GF3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 12:24:45 +0100
Message-Id: <1159874685.17553.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ar Maw, 2006-10-03 am 03:22 +0200, ysgrifennodd Adrian Bunk:
> This patch was already sent on:
> - 7 Jul 2006
> - 26 Jun 2006
> - 27 Apr 2006
> - 19 Apr 2006
> - 6 Jan 2006
> - 13 Dec 2005
> - 23 Nov 2005
> - 18 Nov 2005
> - 12 Nov 2005

This patch was already NAKed on
...

These functions are used internally in the x86 core code correctly and
validly. It's just as easy to find the offenders with grep or building a
PPC tree.
