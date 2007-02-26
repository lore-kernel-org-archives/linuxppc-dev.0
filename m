Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 42F3ADDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 01:41:15 +1100 (EST)
Message-ID: <45E2F179.7070102@am.sony.com>
Date: Mon, 26 Feb 2007 06:40:57 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ps3: always make sure we're running on a PS3
References: <Pine.LNX.4.62.0702221641560.25977@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0702221641560.25977@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> Add missing checks to PS3 specific drivers ps3av and sys-manager to verify that
> we are actually running on a PS3 (pointed out by Arnd).
> 
> Correct existing checks in other subsystems/drivers to return -ENODEV instead
> of zero.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Paul, please apply.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
