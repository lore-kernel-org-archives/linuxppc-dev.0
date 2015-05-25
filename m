Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6F61A0772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 01:24:32 +1000 (AEST)
Received: by pdfh10 with SMTP id h10so71509804pdf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 08:24:31 -0700 (PDT)
Date: Mon, 25 May 2015 08:24:25 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Zidan Wang <zidan.wang@freescale.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_spdif: Don't try to round-up for
 clock divisor calculation
Message-ID: <20150525152424.GA8164@Asurada>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
 <20150525151127.GA8184@Asurada>
 <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 25, 2015 at 12:13:45PM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Mon, May 25, 2015 at 12:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> 
> > Hi Mark,
> >
> > Is that possible for you to provisionally revert this patch?
> > I wanted to wait for the test result from Fabio or Zidan in
> > the Cc list because I don't have a test environment for SPDIF
> > even though this change seems to make sense.
> 
> I currently don't have access to a SPDIF receiver to test it.

Okay, let's wait for Zidan then. We only need to test the
playback route of supporting sample rates.

Thanks
Nicolin
