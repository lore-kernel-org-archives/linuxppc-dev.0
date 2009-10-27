Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id B9D30B7BC3
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 04:45:17 +1100 (EST)
Received: by ywh37 with SMTP id 37so377206ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 10:45:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa40910150946s70ad4013y15cbf9e29c5e50f2@mail.gmail.com>
References: <fa686aa40910150946s70ad4013y15cbf9e29c5e50f2@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Oct 2009 11:44:56 -0600
Message-ID: <fa686aa40910271044w683f78e7odb0d90e48e418e82@mail.gmail.com>
Subject: Re: Please pull mpc5200 and OF changes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Ben,

I don't see these pulled into your tree yet.  Can you please this tree
into your merge branch?

Thanks,
g.

On Thu, Oct 15, 2009 at 10:46 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Hi Ben.
>
> Here are some OF and MPC5200 changes needed for 2.6.32. =A0Mostly
> defconfig updates and a couple of new board dts files.
>
> Cheers,
> g.
>
> The following changes since commit 161291396e76e0832c08f617eb9bd364d16481=
48:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.32-rc4
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 merge
>
> Grant Likely (1):
> =A0 =A0 =A0powerpc/5200: Update defconfigs
>
> Heiko Schocher (2):
> =A0 =A0 =A0mpc5200: support for the MAN mpc5200 based board uc101
> =A0 =A0 =A0mpc5200: support for the MAN mpc5200 based board mucmc52
>
> Julia Lawall (1):
> =A0 =A0 =A0drivers/serial/mpc52xx_uart.c: Use UPIO_MEM rather than SERIAL=
_IO_MEM
>
> J=E9r=F4me Pouiller (1):
> =A0 =A0 =A0of: Remove nested function
>
> Wolfram Sang (1):
> =A0 =A0 =A0powerpc/boot/dts: drop obsolete 'fsl5200-clocking'
>
> =A0arch/powerpc/boot/dts/cm5200.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 -
> =A0arch/powerpc/boot/dts/digsy_mtc.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/lite5200.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 -
> =A0arch/powerpc/boot/dts/lite5200b.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A02 -
> =A0arch/powerpc/boot/dts/media5200.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A02 -
> =A0arch/powerpc/boot/dts/motionpro.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc5121ads.dts =A0 =A0 =A0 =A0 =A0| =A0 =A03 -
> =A0arch/powerpc/boot/dts/mucmc52.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0332 +++=
++++++++++++++++++++++
> =A0arch/powerpc/boot/dts/pcm030.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 -
> =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 -
> =A0arch/powerpc/boot/dts/tqm5200.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/uc101.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0284 +=
++++++++++++++++++++
> =A0arch/powerpc/configs/52xx/cm5200_defconfig =A0 =A0| =A0136 ++++++----
> =A0arch/powerpc/configs/52xx/lite5200b_defconfig | =A0153 ++++++++----
> =A0arch/powerpc/configs/52xx/motionpro_defconfig | =A0146 +++++++----
> =A0arch/powerpc/configs/52xx/pcm030_defconfig =A0 =A0| =A0142 ++++++-----
> =A0arch/powerpc/configs/52xx/tqm5200_defconfig =A0 | =A0148 +++++++----
> =A0arch/powerpc/configs/mpc5200_defconfig =A0 =A0 =A0 =A0| =A0192 +++++++=
+++-----
> =A0arch/powerpc/platforms/52xx/mpc5200_simple.c =A0| =A0 =A02 +
> =A0drivers/of/of_mdio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 13 +-
> =A0drivers/serial/mpc52xx_uart.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
> =A021 files changed, 1196 insertions(+), 371 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/mucmc52.dts
> =A0create mode 100644 arch/powerpc/boot/dts/uc101.dts
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
