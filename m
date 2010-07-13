Return-Path: <jjdanimoth@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id AA596B6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 02:02:43 +1000 (EST)
Received: by wyb32 with SMTP id 32so652040wyb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 09:02:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279033177.515.16.camel@thor.local>
References: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
	<1279030767.515.15.camel@thor.local>
	<AANLkTilk4-gIiJPQb5aqZ5v4YvgzsddexnsmrFBER5HO@mail.gmail.com>
	<1279033177.515.16.camel@thor.local>
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Tue, 13 Jul 2010 18:02:21 +0200
Message-ID: <AANLkTik154EFPIzMZy5v-Mj6mhWt-hCaFYvLPi5oLWFD@mail.gmail.com>
Subject: Re: 2.6.35-rc4 ppc crash when loading radeon modeset=1
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, xorg-driver-ati@lists.x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/7/13 Michel D=C3=A4nzer <michel@daenzer.net>:
[cut]
> Could be a GPU lockup again, possibly due to still using AGP 4x with
> modeset=3D0.
[cut]
> What does the log file contain with modeset=3D1?

We have no message, after the X.org freeze.

messages.log:
[...]
Jul 13 17:11:01 jim kernel: [drm] Num pipes: 1
Jul 13 17:13:39 jim kernel: Using PowerMac machine description

(we have rebooted)

In Xorg.0.log there aren't information after the crash, only a right startu=
p.

Maybe I could try to connect via ssh and see if there are some
informations which aren't written to disk...

At this time, I think it isn't a kernel problem, am I right? Also, we
have the same problem (freeze in glxgears or other program using glx)
both from normal user and from root.

Thank you again
