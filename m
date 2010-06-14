Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 40DB61007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Jun 2010 08:09:11 +1000 (EST)
Received: by yxp4 with SMTP id 4so966773yxp.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Jun 2010 15:09:09 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Jun 2010 16:08:49 -0600
Message-ID: <AANLkTinA4IQeyGE7EsxJwcicKRo7N4-_ez_sqz5G_za_@mail.gmail.com>
Subject: Re: [PATCH 0/2 v2] mpc5200 ac97 gpio reset
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 14, 2010 at 3:55 PM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> These patches reimplement the reset fuction in the ac97 to use gpio pins
> instead of using the mpc5200 ac97 reset functionality in the psc. =A0This
> avoids a problem in which attached ac97 devices go into "test" mode appea=
r
> unresponsive.
>
> These patches were tested on a pcm030 baseboard and on custom hardware wi=
th
> a wm9715 audio codec/touchscreen controller.
>
> Eric Millbrandt
>
> ---
>
> changes since v1
> - Refactored to manipulate port_config and gpio pins internally instead o=
f
> =A0exporting an API.
> - Amended commit message with comments from Mark Brown
> - Refactored to move the port_config manipulation to platform code.
> - Remove the gpio pins from the device-tree
>
> Eric Millbrandt (2):
> =A0 =A0powerpc/5200: add mpc5200_psc_ac97_gpio_reset
> =A0 =A0sound/soc: mpc5200_psc_ac97: Use gpio pins for cold reset
>
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0103 ++++++++++++++++=
++++++++++
> =A0sound/soc/fsl/mpc5200_psc_ac97.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 33 ++++=
+++-
> =A03 files changed, 133 insertions(+), 4 deletions(-)
>
> -DISCLAIMER: an automatically appended disclaimer may follow. By posting-
> -to a public e-mail mailing list I hereby grant permission to distribute-
> -and copy this message.-

Hahahahaha!  You're disclaimer to the disclaimer is awesome.

g.

>
>
>
> This e-mail and the information, including any attachments, it contains a=
re intended to be a confidential communication only to the person or entity=
 to whom it is addressed and may contain information that is privileged. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that any dissemination, distribution or copying of this communicati=
on is strictly prohibited. If you have received this communication in error=
, please immediately notify the sender and destroy the original message.
>
> Thank you.
>
> Please consider the environment before printing this email.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
