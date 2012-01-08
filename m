Return-Path: <hzpeterchen@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1507AB6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2012 14:12:18 +1100 (EST)
Received: by eaal12 with SMTP id l12so1610342eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Jan 2012 19:12:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F088122.4080505@yandex.ru>
References: <4F088122.4080505@yandex.ru>
Date: Sun, 8 Jan 2012 11:12:12 +0800
Message-ID: <CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>
Subject: Re: Driver(s) for Synopsys' DesignWare USB OTG
From: Peter Chen <hzpeterchen@gmail.com>
To: Nikolai Zhubr <n-a-zhubr@yandex.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: support@amlogic.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, openwrt-devel@lists.openwrt.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/1/8 Nikolai Zhubr <n-a-zhubr@yandex.ru>:
> Hello developers,
>
> I'm trying to find/combine/fix a driver for Synopsys' DesignWare USB
> controller. This thing is USB 2.0 host/slave/otg capable and is used in
> various SoCs including Amlogic 8726M, Ralink RT305x, and probably more.
>
> There is some code floating around, partly usable, but all I could see fo=
r
> now is really not perfect. I also saw commit logs on linuxppc-dev, but
> failed to find out what repository they are related to. I'd like to know =
if
> someone is currently developing/testing/maintaining the driver or is
> planning to do so in the near future (in a FOSS-friendly manner - making
> development results public immediately and with eventual goal of inclusio=
n
> into mainline) in order to avoid duplicate/uncoordinated work and waste o=
f
> effort.
>
> I'm currently examining 2 versions (That is, 2 sets of files):
>
> 1. From android kernel for 8726m-based tablets (like the one I own). Usab=
le
> to some extent, but there are issues (e.g. it looks like certain packets =
get
> corrupted, reproducibly, relevant dumps are available)
>
> 2. From openwrt kernel for RT305x-based routers. The code looks a bit mor=
e
> tidy, but not quite well updated (slave-mode parts are unused in openwrt =
and
> they can not even be compiled for modern kernels without certain patching=
;
> have not tried host-mode on the hardware yet)
>
> Quite obviously both versions originated from the same code initially, bu=
t
> subsequently were apparently tested/corrected/updated by separate teams. =
It
> is not quite clear if all bugfixes were cross-applied carefully (if at al=
l).
> I was initially hoping that compare and bisect will just do the job, but =
the
> driver is quite huge... and some files have diverged substantially in the=
 2
> versions, so at the moment I'm a bit fed up and will probably resume a bi=
t
> later. Meanwhile, I'd be happy to discuss the subject with whoever
> interested in order to plan my further steps.

Please see:
http://marc.info/?l=3Dlinux-usb&m=3D129906859817430&w=3D2

I am not sure we can combine all Synopsys USB drivers to single file, but w=
e
can try combine similar IP versions to one file, this work may need all Syn=
opsys
USB IP driver maintainer work together.


> Thank you.
> Nikolai.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
BR,
Peter Chen
