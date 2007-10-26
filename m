Return-Path: <dmitry.torokhov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 2DC04DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 02:05:04 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so775095uge
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 09:05:02 -0700 (PDT)
Message-ID: <d120d5000710260905k4c6391b2j7c3d8528cc8198b0@mail.gmail.com>
Date: Fri, 26 Oct 2007 12:05:01 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
In-Reply-To: <1193336881.4630.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	<1193231110.4510.42.camel@johannes.berg>
	<d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
	<1193233015.4510.44.camel@johannes.berg>
	<d120d5000710240729v2e3faea8u615cfa7f1e489d11@mail.gmail.com>
	<1193318605.6092.11.camel@johannes.berg>
	<1193336881.4630.8.camel@localhost>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/25/07, Benjamin Berg <benjamin@sipsolutions.net> wrote:
> On Thu, 2007-25-10 at 15:23 +0200, Johannes Berg wrote:
> > On Wed, 2007-10-24 at 10:29 -0400, Dmitry Torokhov wrote:
> >
> > > Do yo know who has powerbooks with older geyser models (0x214, 215,
> > > 216)?
> >
> > Not sure, Benjamin? We're talking about the touchpad, just lsusb should
> > be enough.
>
> lsusb says I have a 0x215
> (Bus 003 Device 002: ID 05ac:0215 Apple Computer, Inc.)
>
> Everything is working fine with a 2.6.24-rc1 kernel (ie. no bogus
> messages).
>
> > > It would be nice to know if they send the data continiously and
> > > whether the geyser 3 reset hack works on them.
> >
> > That'd be good, but for fountains it definitely doesn't work.
>
> Benjamin
>

Johannes, and what is product ID for your touchpad?

-- 
Dmitry
