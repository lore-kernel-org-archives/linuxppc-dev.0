Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA0B5DE63B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:41:03 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3TJevEn025489
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 12:40:58 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3TJev2m011774
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 14:40:57 -0500 (CDT)
Date: Tue, 29 Apr 2008 14:40:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Message-ID: <20080429194056.GB9134@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<20080429183559.GE6561@ld0162-tx32.am.freescale.net>
	<3BD17695-2826-43CC-98A0-16F3E33EDC43@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD17695-2826-43CC-98A0-16F3E33EDC43@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 02:36:32PM -0500, Kumar Gala wrote:
> what's an assembler macro look like?

.macro macroname arg1 arg2
	do something with \arg1
	do something with \arg2
.endm

>  I don't believe we use them anywhere else.

arch/powerpc/boot/ps3-hvcall.S uses them, as well as lots of asm code in
other architectures.

-Scott
