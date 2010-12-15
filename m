Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-fx0-f44.google.com (mail-fx0-f44.google.com
	[209.85.161.44]) by ozlabs.org (Postfix) with ESMTP id 8ED441007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 05:40:28 +1100 (EST)
Received: by fxm9 with SMTP id 9so2539116fxm.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 10:40:25 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.01.1012151430220.2052@obet.zrqbmnf.qr>
References: <alpine.LNX.2.01.1012141840130.18577@obet.zrqbmnf.qr>
	<AANLkTimEh+2rEFuq7q+wLcfHw_UKKHVipC0t7mFwSzx8@mail.gmail.com>
	<alpine.LNX.2.01.1012151430220.2052@obet.zrqbmnf.qr>
Date: Wed, 15 Dec 2010 19:40:25 +0100
Message-ID: <AANLkTimqPU-RgNrtNF3WB0KWc-kYXpn12OAefVg2EyTX@mail.gmail.com>
Subject: Re: Force FB off
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Engelhardt <jengelh@medozas.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 15, 2010 at 14:39, Jan Engelhardt <jengelh@medozas.de> wrote:
> On Tuesday 2010-12-14 21:18, Dave Airlie wrote:
>>On Wed, Dec 15, 2010 at 3:41 AM, Jan Engelhardt <jengelh@medozas.de> wrot=
e:
>>
>>>
>>>booting with video=3Doff nor video=3Di915:off has any effect on skipping
>>>FB. What is the correct option to stop FB from taking over my boot
>>>consoles?
>>
>>For KMS its not fb taking over its the drm i915 driver, nomodeset will
>>stop it however X will no longer work since it relies on the kernel
>>driver.
>
> That would make sense. Furthermore I discovered that video=3Dvesafb:off
> also has no effect, but here it is clear because the source code ignores
> the return value of fb_get_options, and so ignores any off command.
>
> The real strange thing is that video=3Doffb:off on an Apple Xserve G5
> PPC64, while probably skipping OFFB initialization, still ends up in a
> 640x480 mode with a 8x16 font instead of retaining the PROM
> console/font.

That just means something different than offb is driving the console now.
What does /proc/fb say?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
