Return-Path: <diggskevin38@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F20FB70D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 09:43:18 +1000 (EST)
Received: by wyg36 with SMTP id 36so1056563wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 16:43:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302736869.28876.91.camel@pasglop>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop>
	<1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
	<1302736869.28876.91.camel@pasglop>
Date: Wed, 13 Apr 2011 18:43:13 -0500
Message-ID: <BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>
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

Hi,

On Wed, Apr 13, 2011 at 6:21 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2011-04-13 at 12:52 -0500, kevin diggs wrote:
>> > Actually I do get a crash in X later on... something in the radeon
>> DRM
>> > interrupt code is getting what looks like a NULL dereference. I'll
>> try
>> > to dig that one later on. I don't know if it's related to your
>> problem
>> > at all though.
>> >
>> In this context, what does 'crash' mean? The X thingy goes down? Or
>> the whole OS?
>
> Depends, with xmon enabled you get into xmon :-) Dunno if the oops is
> fatal but it could be.
>
> Cheers,
> Ben.
>
>

As I think I have the same hardware as you (7,3, radeon 9600) If you
can tell me how to reproduce it maybe I can poke around a little.
Thus, at least temporarily, freeing you up for other stuff.

I kinda need a break from fighting with GCC.

kevin
