Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 97727DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 04:31:13 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ps3: always make sure we're running on a PS3
Date: Thu, 22 Feb 2007 18:30:36 +0100
References: <Pine.LNX.4.62.0702221641560.25977@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0702221641560.25977@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702221830.36975.arnd@arndb.de>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 February 2007, Geert Uytterhoeven wrote:
> Add missing checks to PS3 specific drivers ps3av and sys-manager to verify that
> we are actually running on a PS3 (pointed out by Arnd).
> 
> Correct existing checks in other subsystems/drivers to return -ENODEV instead
> of zero.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
