Return-Path: <vneethv@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49510B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 15:34:39 +1100 (EST)
Received: by bkwj10 with SMTP id j10so1017192bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 21:34:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <EF9AEBBC0B9942B48CE5D29FF5CE814B@sfdomain.com>
References: <EF9AEBBC0B9942B48CE5D29FF5CE814B@sfdomain.com>
From: Vineeth <vneethv@gmail.com>
Date: Wed, 14 Mar 2012 10:04:15 +0530
Message-ID: <CAFbQSaDfvSL7-3VXNddRYAsf9qg5fdkVXLMU=X7r3-TfV4fMvg@mail.gmail.com>
Subject: Re: How to make a memory region to be cache disabled ? Cpu is mpc82XX
 or mpc83XX.
To: hellohello <hellohello008@163.com>
Content-Type: multipart/alternative; boundary=0015175cfd18163c7c04bb2c7e39
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015175cfd18163c7c04bb2c7e39
Content-Type: text/plain; charset=ISO-8859-1

You can disable the cache with the help of TLBs. See where it is creating
TLBs for the memory regions for that processor.

On Wed, Mar 14, 2012 at 8:07 AM, hellohello <hellohello008@163.com> wrote:

> How to make a memory region  to be cache disabled in linux?
> I'm porting mpc83XX from vxworks to linux. Now meet a question: Cpu use a
> memory region (GPCM mode of bus)  to access peripherals, we need this
> memory to be cache disabled.
> Linux Kernel is 2.6.25.
> Thanks very much for any hint!
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--0015175cfd18163c7c04bb2c7e39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

You can disable the cache with the help of TLBs. See where it is creating T=
LBs for the memory regions for that processor.<br><br><div class=3D"gmail_q=
uote">On Wed, Mar 14, 2012 at 8:07 AM, hellohello <span dir=3D"ltr">&lt;<a =
href=3D"mailto:hellohello008@163.com">hellohello008@163.com</a>&gt;</span> =
wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">How to make a memory region =A0to be cache d=
isabled in linux?<br>
I&#39;m porting mpc83XX from vxworks to linux. Now meet a question: Cpu use=
 a memory region (GPCM mode of bus) =A0to access peripherals, we need this =
memory to be cache disabled.<br>
Linux Kernel is 2.6.25.<br>
Thanks very much for any hint!<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--0015175cfd18163c7c04bb2c7e39--
