Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17762.59947.937875.546225@cargo.ozlabs.ibm.com>
Date: Tue, 21 Nov 2006 22:59:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
In-Reply-To: <Pine.LNX.4.62.0611211114220.21124@pademelon.sonytel.be>
References: <4554DACB.8060809@am.sony.com> <4559099A.6060805@am.sony.com>
	<17762.26999.152198.792581@cargo.ozlabs.ibm.com>
	<200611211111.12882.arnd@arndb.de>
	<Pine.LNX.4.62.0611211114220.21124@pademelon.sonytel.be>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven writes:

> Indeed, and since we don't like changing all of these back and forth, it would
> be nice to have a definitive decision soon.

Put the ps3 support in arch/powerpc/platforms/ps3.  If there are
hypervisor-specific routines, they can have a ps3pf_ prefix if you
want.

Paul.
