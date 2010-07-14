Return-Path: <jgpobox@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id B3A4BB6F16
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 17:51:50 +1000 (EST)
Received: by gwb11 with SMTP id 11so2559239gwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 00:51:48 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4C3D6C90.4030709@pobox.com>
Date: Wed, 14 Jul 2010 03:51:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH v2]460EX on-chip SATA driver<resubmisison>
References: <201007061106.o66B631f013777@amcc.com>
In-Reply-To: <201007061106.o66B631f013777@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, sr@denx.de, rsarmah@apm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2010 07:06 AM, Rupjyoti Sarmah wrote:
> This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
>
> Signed-off-by: Rupjyoti Sarmah<rsarmah@appliedmicro.com>
> Signed-off-by: Mark Miesfeld<mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika<phazarika@appliedmicro.com>
>
> ---
> This patch incorporates the changes advised in the mailing list. The device
> tree changes were submitted as a seperate patch. Kconfig file is fixed in this version.
>
>   drivers/ata/Kconfig          |    9 +
>   drivers/ata/Makefile         |    1 +
>   drivers/ata/sata_dwc_460ex.c | 1756 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1766 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/sata_dwc_460ex.c

applied
