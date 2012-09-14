Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "dekaexchange07", Issuer "dekaexchange07" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 078192C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2012 00:45:44 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: "'agust@denx.de'" <agust@denx.de>
Date: Fri, 14 Sep 2012 10:45:32 -0400
Subject: RE: [PATCH 1/7] powerpc/52xx: define FSL_SOC
Message-ID: <0A40042D85E7C84DB443060EC44B3FD336D854FEF9@dekaexchange07.deka.local>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-2-git-send-email-emillbrandt@dekaresearch.com>
 <20120914113100.119048xeot7zcym8@webmail.mnet-online.de>
In-Reply-To: <20120914113100.119048xeot7zcym8@webmail.mnet-online.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012-09-14 agust@denx.de wrote:
> Eric Millbrandt <emillbrandt@dekaresearch.com> wrote:
>
...
>
> Better use:
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig index
> d701330..4563b28 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -6,7 +6,7 @@ config SND_SOC_FSL_UTILS
>
>   menuconfig SND_POWERPC_SOC
>          tristate "SoC Audio for Freescale PowerPC CPUs"
> -       depends on FSL_SOC
> +       depends on FSL_SOC || PPC_MPC52xx
>          help
>            Say Y or M if you want to add support for codecs attached to
>            the PowerPC CPUs.
> Thanks,
>
> Anatolij
>

Looks good to me, I will do this instead.  Thanks.

Eric


-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
