Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196]) by ozlabs.org (Postfix) with ESMTP id D7BA7B7D60
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 06:33:55 +1100 (EST)
Received: by yxe34 with SMTP id 34so3620510yxe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 11:33:54 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264191502.2224.2@antares>
References: <1264191502.2224.2@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 12:33:34 -0700
Message-ID: <fa686aa41002161133w67bd08ffr2b453498e22d3892@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/2] 5200: improve i2c bus error recovery
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 22, 2010 at 1:18 PM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Make the I2C adapter timeout configurable through a Device Tree property
> which gives the timeout in microseconds.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
> ---
>
> --- linux-2.6.32-orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt =A0 =
=A02009-12-03 04:51:21.000000000 +0100
> +++ linux-2.6.32/Documentation/powerpc/dts-bindings/fsl/i2c.txt 2010-01-2=
2 16:04:56.000000000 +0100
> @@ -21,6 +21,7 @@
> =A0- fsl,preserve-clocking : boolean; if defined, the clock settings
> =A0 =A0from the bootloader are preserved (not touched).
> =A0- clock-frequency : desired I2C bus clock frequency in Hz.
> + - timeout : I2C timeout in microseconds.

fsl,timeout to avoid namespace collisions please (ie. if a common i2c
'timeout' property is ever defined for all i2c busses)

g.
