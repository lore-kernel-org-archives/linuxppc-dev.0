Return-Path: <rsarmah@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id 4F06DB6EED
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 22:20:39 +1000 (EST)
Received: by wwi14 with SMTP id 14so4016385wwi.21
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 05:20:35 -0700 (PDT)
From: Rupjyoti Sarmah <rsarmah@apm.com>
References: <201006041226.o54CQH2V017366@amcc.com>
	<201006290333.50673.marek.vasut@gmail.com>
In-Reply-To: <201006290333.50673.marek.vasut@gmail.com>
MIME-Version: 1.0
Date: Tue, 29 Jun 2010 17:50:32 +0530
Message-ID: <5db514a6e3b22cd59eeaa1acc716be5a@mail.gmail.com>
Subject: RE: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>
To: Marek Vasut <marek.vasut@gmail.com>, Rupjyoti Sarmah <rsarmah@amcc.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

Thanks for your feedback. I submitted an updated version of this patch
later.
I tried to limit the lines within 80 characters.

Regards,
Rup


-----Original Message-----
From: Marek Vasut [mailto:marek.vasut@gmail.com]
Sent: Tuesday, June 29, 2010 7:04 AM
To: Rupjyoti Sarmah
Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org;
jgarzik@pobox.com; sr@denx.de; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>

Dne P=C3=A1 4. =C4=8Dervna 2010 14:26:17 Rupjyoti Sarmah napsal(a):
> This patch enables the on-chip DWC SATA controller of the AppliedMicro
> processor 460EX.
>
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
>

--SNIP--

> +		dev_err(ap->dev, "%s: Command not pending cmd_issued=3D%d "
> +			"(tag=3D%d) DMA NOT started\n", __func__,
> +			hsdevp->cmd_issued[tag], tag);

Just a nitpick, but don't break strings if possible.
