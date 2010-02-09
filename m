Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f178.google.com (mail-iw0-f178.google.com
	[209.85.223.178]) by ozlabs.org (Postfix) with ESMTP id 43700B7D4D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 09:19:19 +1100 (EST)
Received: by iwn8 with SMTP id 8so2463574iwn.13
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 14:19:17 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265750032-2803-1-git-send-email-agust@denx.de>
References: <1265750032-2803-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 15:18:57 -0700
Message-ID: <fa686aa41002091418q2e97919ft2bcf8ad02e050afa@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] powerpc: mpc5121: PSC UART support
To: Anatolij Gustschin <agust@denx.de>, Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg, since this touches powerpc stuff, do you mind if I pick up the
series into my tree?

Thanks,
g.

On Tue, Feb 9, 2010 at 2:13 PM, Anatolij Gustschin <agust@denx.de> wrote:
> The support for mpc5121 PSC UART currently only works with
> serial console. This patch series re-enable PSC UART support for
> all 12 PSCs and document added DTS bingings.
>
> Anatolij Gustschin (3):
> =A0serial: mpc52xx_uart: re-enable mpc5121 PSC UART support
> =A0powerpc: doc/dts-bindings: document mpc5121 psc uart =A0dts-bindings
> =A0powerpc: mpc5121: enable support for more PSC UARTs
>
> =A0.../powerpc/dts-bindings/fsl/mpc5121-psc.txt =A0 =A0 =A0 | =A0 70 ++++=
++
> =A0arch/powerpc/include/asm/mpc52xx_psc.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 +
> =A0drivers/serial/mpc52xx_uart.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0251 ++++++++++++++++++--
> =A03 files changed, 310 insertions(+), 15 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.=
txt
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
