Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 51BB667BD5
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 01:32:08 +1100 (EST)
Date: Thu, 23 Nov 2006 15:32:06 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Missed renames of CONFIG_PS3 to CONFIG_PPC_PS3
In-Reply-To: <200611231409.55709.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0611231530260.25303@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0611231346070.15461@pademelon.sonytel.be>
	<200611231409.55709.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Nov 2006, Arnd Bergmann wrote:
> On Thursday 23 November 2006 13:50, Geert Uytterhoeven wrote:
> > When renaming CONFIG_PS3 to CONFIG_PPC_PS3, a few occurrences have been
> > missed.
> 
> Sorry about this, my fault. I checked the Kconfig and .c files, but
> missed the Makefiles.

Bummer, I found another one in <asm/firmware.h> (he who uses `grep
CONFIG_PS3[^_])' doesn't match end of lines), which explains why the resulting
kernel didn't boot that far...

I'll send an updated patch in a few minutes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
