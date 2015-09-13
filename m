Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 608A61A2BF7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 06:23:51 +1000 (AEST)
Received: by obbda8 with SMTP id da8so94719709obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2015 13:23:49 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150913151926.GA19850@roeck-us.net>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
 <20150913151926.GA19850@roeck-us.net>
Date: Sun, 13 Sep 2015 22:23:49 +0200
Message-ID: <CAMuHMdVGEDKFxD7wf6ZOAGiOByM5c0Awx-anLsYGLQHV1yJW+w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.3-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <michael@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 13, 2015 at 5:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Sep 13, 2015 at 11:03:51AM +0200, Geert Uytterhoeven wrote:
>> On Sun, Sep 13, 2015 at 11:01 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > Below is the list of build error/warning regressions/improvements in
>> > v4.3-rc1[1] compared to v4.2[2].
>> >
> [ ... ]
>
>>
>> >   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error: 'last_=
sc' may be used uninitialized in this function [-Werror=3Duninitialized]:  =
=3D> 1094:31
>>
>> powerpc-allyesconfig, powerpc-randconfig, powerpc-allmodconfig
>
> I think that only affects powerpc-randconfig.

Right, on powerpc-all{mod,yes}config it's just a build warning, not an erro=
r.

> arm64:allmodconfig:
>
> drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal befo=
re =E2=80=98__asmeq=E2=80=99
> drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of func=
tion =E2=80=98secure_flush_area=E2=80=99
> drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of func=
tion =E2=80=98outer_inv_range=E2=80=99
> drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal befo=
re =E2=80=98__asmeq=E2=80=99
> drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal befo=
re =E2=80=98__asmeq=E2=80=99

Time for kisskb to gain arm64 support?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
