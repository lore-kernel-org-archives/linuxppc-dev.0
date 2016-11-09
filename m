Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDf6g6w3wzDvf7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 08:13:30 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Dirk Behme <dirk.behme@de.bosch.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Simon Horman <horms@verge.net.au>, Yangbo Lu <yangbo.lu@nxp.com>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
Date: Wed, 09 Nov 2016 22:12:32 +0100
Message-ID: <6723536.97ljqcB8tS@wuerfel>
In-Reply-To: <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1626072.dpWPnWgGl9@wuerfel>
 <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, November 9, 2016 6:19:06 PM CET Geert Uytterhoeven wrote:
> On Wed, Nov 9, 2016 at 5:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday, November 9, 2016 2:34:33 PM CET Geert Uytterhoeven wrote:
> >> > And Samsung.
> >> > Shall I create the immutable branch now?
> >>
> >> Arnd: are you happy with the new patches and changes?
> >
> > I still had some comments for patch 7, but that shouldn't stop
> > you from creating a branch for the first three so everyone can
> > build on top of that.
> 
> Thanks!
> 
> What about patch [4/7]?
> Haven't you received it? Your address was in the To-line for all 7 patches.

Ok, I see it now, looks good. That should be included as well then.

	Arnd
