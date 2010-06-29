Return-Path: <marek.vasut@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id D92C4B6EED
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:36:12 +1000 (EST)
Received: by bwz19 with SMTP id 19so814249bwz.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 18:36:10 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>
Date: Tue, 29 Jun 2010 03:33:50 +0200
References: <201006041226.o54CQH2V017366@amcc.com>
In-Reply-To: <201006041226.o54CQH2V017366@amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201006290333.50673.marek.vasut@gmail.com>
Cc: linux-ide@vger.kernel.org, sr@denx.de, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dne P=C3=A1 4. =C4=8Dervna 2010 14:26:17 Rupjyoti Sarmah napsal(a):
> This patch enables the on-chip DWC SATA controller of the AppliedMicro
> processor 460EX.
>=20
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
>=20

=2D-SNIP--

> +		dev_err(ap->dev, "%s: Command not pending cmd_issued=3D%d "
> +			"(tag=3D%d) DMA NOT started\n", __func__,
> +			hsdevp->cmd_issued[tag], tag);

Just a nitpick, but don't break strings if possible.
