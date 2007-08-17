Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B531EDDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 02:03:51 +1000 (EST)
Message-ID: <46C5C6DA.1020208@freescale.com>
Date: Fri, 17 Aug 2007 11:03:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] powerpc: add setclrbits macros
References: <11873041991712-git-send-email-timur@freescale.com>
	<Pine.LNX.4.62.0708170843060.8381@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0708170843060.8381@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:

> Sorry for nitpicking again, but since the clear is done before the set (cfr.
> the expanded functionality), perhaps they should be changed to
> clrsetbits_X(addr, clear, set)?

*sigh*

You're right.  New patch coming soon.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
