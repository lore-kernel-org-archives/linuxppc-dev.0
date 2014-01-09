Return-Path: <festevam@gmail.com>
Received: from mail-vb0-x230.google.com (mail-vb0-x230.google.com
 [IPv6:2607:f8b0:400c:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1EAFF2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 21:41:01 +1100 (EST)
Received: by mail-vb0-f48.google.com with SMTP id q16so273587vbe.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jan 2014 02:40:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140109103453.GC14809@MrMyself>
References: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOMZO5C8hGYehqJ6WFUKye8wENuAejT-YXggeYy7V+DQ2_OMHg@mail.gmail.com>
 <20140109103453.GC14809@MrMyself>
Date: Thu, 9 Jan 2014 08:40:58 -0200
Message-ID: <CAOMZO5DTbZXE3zzWoVyuM98HcbRNqMOjfK_1VW7=hAKVijtMKQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Set default slot number for
 common cases
From: Fabio Estevam <festevam@gmail.com>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
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

On Thu, Jan 9, 2014 at 8:34 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:

> Is this for the initial line? The CodingStyle contains two types of multi-line

Yes, correct.

> comment, one of which drops the initial line just like mine, even though it's
> saying 'For files in net/ and drivers/net/ the preferred style', so I thought
> it shouldn't be quite bother.

Yes, net and drivers/net are different and checkpatch reports it accordingly.

Regards,

Fabio Estevam
