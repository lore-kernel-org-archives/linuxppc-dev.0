Return-Path: <festevam@gmail.com>
Received: from mail-ve0-x233.google.com (mail-ve0-x233.google.com
 [IPv6:2607:f8b0:400c:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 416E32C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 21:08:19 +1100 (EST)
Received: by mail-ve0-f179.google.com with SMTP id jw12so9701840veb.24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jan 2014 02:08:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
References: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
Date: Tue, 7 Jan 2014 08:08:14 -0200
Message-ID: <CAOMZO5AK3=d322K80a6Y16xWKFYy9dWJEupF6W8mqLxm0_=j8g@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Fixed wrong printf format
 identifier
From: Fabio Estevam <festevam@gmail.com>
To: Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset=UTF-8
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 7, 2014 at 4:04 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
> sound/soc/fsl/fsl_ssi.c:1180:6: warning: format '%d' expects argument
> of type 'int', but argument 3 has type 'long int' [-Wformat=]
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I have sent the same fix as well as I haven't seen your patch before I
submitted mine.

It is usually a good idea to specify in the commit log what was the
commit that caused the warning.

Regards,

Fabio Estevam
