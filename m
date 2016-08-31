Return-Path: <festevam@gmail.com>
Received: from mail-ua0-x233.google.com (mail-ua0-x233.google.com
 [IPv6:2607:f8b0:400c:c08::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPYBJ3qMhzDrfP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 04:02:15 +1000 (AEST)
Received: by mail-ua0-x233.google.com with SMTP id i32so102501264uai.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 11:02:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160831174947.GA2018@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
 <20160831042100.GA3308@Asurada> <20160831091013.GA3185@begut>
 <CAOMZO5AoCo9Faq7oWgRQUE0Hg+Pg+i6z8eg-qeLFDvwpoEqz_g@mail.gmail.com>
 <20160831134925.GB1967@begut> <20160831174947.GA2018@begut>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 31 Aug 2016 15:02:12 -0300
Message-ID: <CAOMZO5CN0ZYcHq9PqVTRtGgp3btMPEk3jE9nkkrdppD=HMZgiQ@mail.gmail.com>
Subject: Re: [alsa-devel] Setting some clocks back to DUMMY fixes spdif output
 on imx6q wandboard rev B1
To: Xavi Drudis Ferran <xdrudis@tinet.cat>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Timur Tabi <timur@tabi.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2016 at 2:49 PM, Xavi Drudis Ferran <xdrudis@tinet.cat> wrote:

> Thank you amd feel free to suggest more tests, but it is good enough
> as it is for me.

Ok, thanks for trying. So let's keep the SPDIF parent clock as is.
