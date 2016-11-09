Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDXZ52zFjzDvNH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:03:24 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
Date: Wed, 09 Nov 2016 17:56:37 +0100
Message-ID: <1626072.dpWPnWgGl9@wuerfel>
In-Reply-To: <CAMuHMdUmpMpizZpq1V-sLA8Cf2q5oOgOVxGOvKXqTHvn+Mj7Tg@mail.gmail.com>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdV4HG0aOr4Qp_OZXU=3jLeOJ2QaMKp09a3v4489ABbRcA@mail.gmail.com>
 <CAMuHMdUmpMpizZpq1V-sLA8Cf2q5oOgOVxGOvKXqTHvn+Mj7Tg@mail.gmail.com>
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

On Wednesday, November 9, 2016 2:34:33 PM CET Geert Uytterhoeven wrote:
> >
> > And Samsung.
> > Shall I create the immutable branch now?
> 
> Arnd: are you happy with the new patches and changes?

I still had some comments for patch 7, but that shouldn't stop
you from creating a branch for the first three so everyone can
build on top of that.

	Arnd
