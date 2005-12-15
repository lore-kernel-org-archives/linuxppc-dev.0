Return-Path: <dmitry.torokhov@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id 28D2F68869
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 08:38:54 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i2so793681wra
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 13:38:53 -0800 (PST)
Message-ID: <d120d5000512151338p7ec77170i555358b9624c1649@mail.gmail.com>
Date: Thu, 15 Dec 2005 16:38:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20051215212635.GA6195@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051213223659.GB20017@hansmi.ch>
	<1134568620.3875.6.camel@localhost> <20051214213923.GB17548@hansmi.ch>
	<d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
	<20051214233108.GA20127@hansmi.ch>
	<20051215195017.GA7195@pb15.lixom.net>
	<20051215212635.GA6195@hansmi.ch>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-input@atrey.karlin.mff.cuni.cz, kernel-stuff@comcast.net
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/15/05, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> On Thu, Dec 15, 2005 at 11:50:17AM -0800, Olof Johansson wrote:
> > I think I agree with previous comments regarding debug code in the driv=
er:
> > It's unlikely to ever be used by more than a couple of people at very
> > rare occasions (new hardware releases), and the barrier to using it is
> > still high; new users need to learn how to parse the data anyway. I don=
't
> > see a reason to include this in mainline.
>
> Okay, based on your comments, please drop that patch. How about the one
> to support the Geyser 2 device? Should I do a rediff without relayfs
> support?
>

If you could rediff it without relayfs I would add it to the input
tree. Altough I am not sure if manually unrolling that loop is such a
good idea. Maybe we should leave it to the compiler?

--
Dmitry
