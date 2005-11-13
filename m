Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F05C168734
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2005 08:03:24 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<1131834336.7406.46.camel@gaston>
	<71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 07:59:20 +1100
Message-Id: <1131915560.5504.67.camel@gaston>
Mime-Version: 1.0
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>, Linus Torvalds <torvalds@osdl.org>,
	Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-11-13 at 10:37 -0600, Kumar Gala wrote:

> Can we please add some defconfigs for arch/powerpc to possibly help  
> with this issue.  I'm think a pmac32, pmac64, and whatever other 64  
> bit configs would be a good start.

The 64 bits defconfigs are there already. I'll do a pmac one.

Ben.
