Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24A50DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 07:57:30 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH][v2] powerpc 44x: support for 256KB PAGE_SIZE
References: <200812211446.56783.yur@emcraft.com>
	<je4p0x319s.fsf@sykes.suse.de> <947420693.20081221230007@emcraft.com>
	<jelju91e1q.fsf@sykes.suse.de> <121213804.20081221233548@emcraft.com>
Date: Sun, 21 Dec 2008 21:57:23 +0100
In-Reply-To: <121213804.20081221233548@emcraft.com> (Yuri Tikhonov's message
	of "Sun, 21 Dec 2008 23:35:48 +0300")
Message-ID: <jehc4x1c24.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: wd@denx.de, dzu@denx.de, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yuri Tikhonov <yur@emcraft.com> writes:

>  Because, in any case, either should we patch binutils, or should we 
> pass some non-default value to the linker: the resulted application 
> doesn't match the ELF standard

An ELF object built with a 256k alignment of is still perfectly
compliant.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
