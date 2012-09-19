Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "dekaexchange07", Issuer "dekaexchange07" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1BC92C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 07:06:21 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, Grant Likely
 <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>
Date: Wed, 19 Sep 2012 17:07:34 -0400
Subject: RE: [PATCH v2 1/7] ASoC: fsl: add PPC_MPC52xx dependency to
 SND_POWERPC_SOC
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3459868BAC0@dekaexchange07.deka.local>
References: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
 <20120919204730.GB12297@opensource.wolfsonmicro.com>
In-Reply-To: <20120919204730.GB12297@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012-09-19 Mark Brown wrote:
> On Wed, Sep 19, 2012 at 10:51:25AM -0400,  wrote:
>> From: Eric Millbrandt <emillbrandt@dekaresearch.com>
>>
>> mpc52xx socs need to define SND_POWERPC_SOC to build ASoC drivers.
>>
>> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com> ---
>> Changes since v1: Patch was "powerpc/52xx: define FSL_SOC" Changed from
>> defining FSL_SOC for PPC_MPC52xx to adding PPC_MPC52xx as a dependency
>> of SND_POWERPC_SOC as per Anatolij Gustschin's comment.
>
> Patches 2 to 7 appear to have gone AWOL?
>
No changes to 2 through 7, so I didn't repost the full series.

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
