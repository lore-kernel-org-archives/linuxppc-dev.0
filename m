Return-Path: <xdrudis@tinet.cat>
Received: from mx2.tinet.org (mx2.tinet.org [195.77.216.147])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sPRXX2GY8zDrfP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:47:39 +1000 (AEST)
Received: from smtp01.tinet.org (smtp01.tinet.org [195.77.216.131]) by
 mx2.tinet.org with ESMTP id gp30hArnGjZgnAsF for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 15:47:36 +0200 (CEST)
Date: Wed, 31 Aug 2016 15:47:33 +0200
From: Xavi Drudis Ferran <xdrudis@tinet.cat>
To: Fabio Estevam <festevam@gmail.com>
Cc: Xavi Drudis Ferran <xdrudis@tinet.cat>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] Setting some clocks back to DUMMY fixes spdif
 output on imx6q wandboard rev B1
Message-ID: <20160831134733.GA1967@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
 <20160831042100.GA3308@Asurada> <20160831091013.GA3185@begut>
 <CAOMZO5AoCo9Faq7oWgRQUE0Hg+Pg+i6z8eg-qeLFDvwpoEqz_g@mail.gmail.com>
 <CAOMZO5CFsXR8zsPXGOKMqfFkCjzdpTbHz=u8DjQODY4hSakv9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5CFsXR8zsPXGOKMqfFkCjzdpTbHz=u8DjQODY4hSakv9Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

El Wed, Aug 31, 2016 at 10:30:25AM -0300, Fabio Estevam deia:
> Xavi,
> 
> On Wed, Aug 31, 2016 at 10:11 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > Xavi,
> >
> > Care to send a formal patch with your change?
> 
> If you prefer, I can send this change to the ARM kernel mailing list.
>

Whatever is easier for you. I'll have to look up the formalities for
sending the patch myself (format, copyright, where to send, etc.)
since I've never sent a patch for linux. I don't believe such a simple
change can be copyrightable, but the original isn't mine, it's from
that URL I gave, https://community.nxp.com/thread/387131 so originally
from ambika@iwavesystems.com

> Please let me know what you prefer.
>

If it's easy for you to send it yourself, I would prefer so and I'm
grateful. If not, it'll be an exercise for me, no problem.
