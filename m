Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 143E71A04F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 14:22:37 +1000 (EST)
Date: Fri, 13 Jun 2014 11:50:50 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
Message-ID: <20140613035049.GB15609@MrMyself>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
 <20140613032119.GA15609@MrMyself>
 <CAOZdJXUUz2bufcYmt9U-x0bic6XU68VHLOiPPsHoEdSZmnisZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOZdJXUUz2bufcYmt9U-x0bic6XU68VHLOiPPsHoEdSZmnisZw@mail.gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
 alsa-devel mailing list <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam
 Girdwood <lgirdwood@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2014 at 10:44:48PM -0500, Timur Tabi wrote:
> On Thu, Jun 12, 2014 at 10:21 PM, Nicolin Chen
> <Guangyu.Chen@freescale.com> wrote:
> 
> > It compiles well with my ARM cross compiler. I guess it might be related
> > to the compiler's version? But we should fix it anyway. Would you mind if
> > I submit a patch? Or you do it directly?
> 
> I just submitted a patch, but I can't test the code since I don't have
> any boards that configure the SSI into master mode, so this function
> is never called.

I just tested it with i.MX platform. It still works.

Thank you,
Nicolin
