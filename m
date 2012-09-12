Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "dekaexchange07", Issuer "dekaexchange07" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 975712C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 00:29:42 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Date: Wed, 12 Sep 2012 10:29:38 -0400
Subject: RE: [PATCH 1/5] ASoC: fsl: mpc5200 multi-codec fixups
Message-ID: <0A40042D85E7C84DB443060EC44B3FD336D854FEE4@dekaexchange07.deka.local>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-2-git-send-email-emillbrandt@dekaresearch.com>
 <20120912030457.GF9162@opensource.wolfsonmicro.com>
In-Reply-To: <20120912030457.GF9162@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Anatolij Gustschin <agust@denx.de>,
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

Hi Mark,

On 2012-09-11 Mark Brown wrote:
>> --- a/arch/powerpc/platforms/52xx/Kconfig
>> +++ b/arch/powerpc/platforms/52xx/Kconfig
>> @@ -1,6 +1,7 @@
>>  config PPC_MPC52xx  bool "52xx-based boards"        depends on 6xx +   =
     select
>>  FSL_SOC     select PPC_CLOCK        select PPC_PCI_CHOICE
>
> This doesnt seem to have much to do with the commit message...
>
I'll spit this into another patch.  SND_POWERPC_SOC, which wraps all of the=
 Powerpc socs, depends on FSL_SOC.  Would it be better to have SND_POWERPC_=
SOC depend on FSL_SOC or PPC_MPC52xx?

>> -/* ALSA only supports a single AC97 device so static is recommend here
>> */ +/* ALSA only supports a single AC97 bus device so static is
>> recommend +here */
>>  static struct psc_dma *psc_dma;
>
> Or this.
>
I'll also be split this out.  The change was to clarify that now you can ha=
ve multiple ac97 codec, but soc-core can still only have on ac97 bus.

Eric




This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
