Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97A261A0125
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 13:44:51 +1000 (EST)
Received: from mail-ve0-f175.google.com (mail-ve0-f175.google.com
 [209.85.128.175])
 by muin.pair.com (Postfix) with ESMTPSA id 4E8648FC1A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 23:44:49 -0400 (EDT)
Received: by mail-ve0-f175.google.com with SMTP id jx11so33099veb.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 20:44:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140613032119.GA15609@MrMyself>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
 <20140613032119.GA15609@MrMyself>
Date: Thu, 12 Jun 2014 22:44:48 -0500
Message-ID: <CAOZdJXUUz2bufcYmt9U-x0bic6XU68VHLOiPPsHoEdSZmnisZw@mail.gmail.com>
Subject: Re: [alsa-devel] [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
From: Timur Tabi <timur@tabi.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2014 at 10:21 PM, Nicolin Chen
<Guangyu.Chen@freescale.com> wrote:

> It compiles well with my ARM cross compiler. I guess it might be related
> to the compiler's version? But we should fix it anyway. Would you mind if
> I submit a patch? Or you do it directly?

I just submitted a patch, but I can't test the code since I don't have
any boards that configure the SSI into master mode, so this function
is never called.
