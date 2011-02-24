Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E33D9B7088
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2011 05:52:03 +1100 (EST)
Received: by iyb12 with SMTP id 12so559483iyb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 10:52:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1298506192.8833.222.camel@pasglop>
References: <AANLkTinz=CrCTEeAPQjE8B=yjQx+WLs_FKj2u+0-JeAS@mail.gmail.com>
	<1298490130.8833.212.camel@pasglop>
	<AANLkTinB+CLhJsiu3SBygC7TW+vnOH3e7==h_7nEGWts@mail.gmail.com>
	<1298506192.8833.222.camel@pasglop>
Date: Thu, 24 Feb 2011 12:52:00 -0600
Message-ID: <AANLkTi=uF9i3F-e8qvqpf0PV_V7zfWouByubqt6=Ya6a@mail.gmail.com>
Subject: Re: rtc on PowerMac7,3
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Thanks for taking some of your valuable time to reply.

Now I can't get it to fail. I don't know what I did wrong??? These
things are tryin' to push me over the edge!

Part of the problem may be the /dev/rtc (10:135 or whatever the PC
numbers are) PC device that gets put into /dev/ (udev) on YDL 6.0.
Should probably figure out who is adding it and nuke it.

Sorry for the noise!?!

kevin

On Wed, Feb 23, 2011 at 6:09 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Not sure, I haven't looked at that RTC stuff for ages. Basically the
> platform code provides generic RTC hooks (in that G5 it's going to be
> via the via-pmu) and it should "just work". That code hasn't been
> touched for eons.
>
> Cheers,
> Ben.
>
