Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 844B867B52
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:05:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Fri, 18 Aug 2006 21:05:44 +0200
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
	<1155924687.9659.25.camel@farscape.rchland.ibm.com>
In-Reply-To: <1155924687.9659.25.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Message-Id: <200608182105.45264.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 August 2006 20:11, Will Schmidt wrote:
> +#define INST_POPCNTB           0x7c0000f4
> +

> +=A0=A0=A0=A0=A0=A0=A0/* Emulate the popcntb (Population Count Bytes) ins=
truction. */
> +=A0=A0=A0=A0=A0=A0=A0if ((instword & INST_POPCNTB) =3D=3D INST_POPCNTB) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return emulate_popcntb_inst=
(regs, instword);
> +=A0=A0=A0=A0=A0=A0=A0}
> +

Is that the right check? The other similar traps check against a
mask of 0x7c0007fe.

	Arnd <><
