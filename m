Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 4FEA3DEB6D
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 01:21:03 +1000 (EST)
Received: by qyk34 with SMTP id 34so5416997qyk.17
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 08:21:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090525102647.GD18290@sirena.org.uk>
References: <20090525013849.3073.96729.stgit@terra>
	<20090525102647.GD18290@sirena.org.uk>
Date: Mon, 25 May 2009 11:21:01 -0400
Message-ID: <9e4733910905250821nf433121s6c161d3f2104b453@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
From: Jon Smirl <jonsmirl@gmail.com>
To: grant.likely@secretlab.ca
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 6:26 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&psc_dma->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_slots, psc_d=
ma->slots);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&psc_dma->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> This locking looks wrong - I'd expect it to also cover the modification
> of psc_dma->slots? =A0Otherwise it's hard to see what it buys you.

Grant, why are you spin locking around register access?


--=20
Jon Smirl
jonsmirl@gmail.com
