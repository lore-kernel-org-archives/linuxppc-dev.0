Return-Path: <diggskevin38@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B444B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 03:52:14 +1000 (EST)
Received: by pvf33 with SMTP id 33so352546pvf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 10:52:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302685102.28876.81.camel@pasglop>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop>
	<1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
Date: Wed, 13 Apr 2011 12:52:11 -0500
Message-ID: <BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mikael Pettersson <mikpe@it.uu.se>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HI,

On Wed, Apr 13, 2011 at 3:58 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Actually I do get a crash in X later on... something in the radeon DRM
> interrupt code is getting what looks like a NULL dereference. I'll try
> to dig that one later on. I don't know if it's related to your problem
> at all though.
>
In this context, what does 'crash' mean? The X thingy goes down? Or
the whole OS?

Cheers,
kevin.

> Cheers,
> Ben.
