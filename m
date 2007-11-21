Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18244.42350.871320.117319@cargo.ozlabs.ibm.com>
Date: Thu, 22 Nov 2007 08:38:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
In-Reply-To: <Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven writes:

> Question: do we want it for emulate_single_step(), too?

No, because that's not emulating an instruction.

Paul.
