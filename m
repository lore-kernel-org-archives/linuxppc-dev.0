Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "dekaexchange07", Issuer "dekaexchange07" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BE372C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 00:11:14 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Date: Wed, 12 Sep 2012 10:05:33 -0400
Subject: RE: [PATCH 5/5] ASoC: fsl: mpc5200 remove pcm030 and efika audio
 fabric
Message-ID: <0A40042D85E7C84DB443060EC44B3FD336D854FEE2@dekaexchange07.deka.local>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-6-git-send-email-emillbrandt@dekaresearch.com>
 <20120912032026.GI9162@opensource.wolfsonmicro.com>
In-Reply-To: <20120912032026.GI9162@opensource.wolfsonmicro.com>
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
> On Tue, Sep 11, 2012 at 10:14:49PM -0400, Eric Millbrandt wrote:
>> MPC5200 ASoC setup can now be done in the device tree.
>
> I only noticed DT bindings being added for pcm030, not for efika?
>
When I looked I didn't see the Efika (PPC 5200B) DT in-tree.  It only appea=
rs to exist out-of-tree, http://www.powerdeveloper.org/platforms/efika/devi=
cetree.

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
