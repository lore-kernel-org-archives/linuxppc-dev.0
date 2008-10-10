Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove bogus ppc_select syscall
Date: Fri, 10 Oct 2008 10:45:20 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1223612981.8157.146.camel@pasglop>
	<18671.1955.407703.974646@cargo.ozlabs.ibm.com>
In-Reply-To: <18671.1955.407703.974646@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810101045.21281.arnd@arndb.de>
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 October 2008, Paul Mackerras wrote:
> Please don't apply Arnd's patch. =A0As I said, all we need is this
> one-line change in arch/powerpc/include/asm/systbl.h:
>=20
> -SYSX_SPU(sys_select,ppc32_select,ppc_select)
> +SYSX_SPU(sys_select,ppc32_select,sys_select)
>=20
> Paul.

=46WIW,

Acked-by: Arnd Bergmann <arnd@arndb.de>
