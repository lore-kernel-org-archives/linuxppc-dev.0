Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D43EEB7DA1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:41:52 +1100 (EST)
Date: Thu, 18 Feb 2010 13:41:50 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/15] powerpc: raw_spinlock conversions
In-Reply-To: <20100218121904.620984825@linutronix.de>
Message-ID: <alpine.LRH.2.00.1002181341150.25717@mink.sonytel.be>
References: <20100218121904.620984825@linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Feb 2010, Thomas Gleixner wrote:
> the following patch series is from preempt-rt. It converts the locks
> which need to be real spinlocks in -rt to raw_spinlocks.

None of the patch descriptions mention why the locks need to be real
spinlocks in -rt. So can you please elaborate?

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
