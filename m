Return-Path: <ashwath.narasimhan@oneconvergence.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B466FB6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 04:35:42 +1000 (EST)
Received: by iyn35 with SMTP id 35so1465453iyn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 11:35:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTi=j1FwEv2tBmPck3GWHWgcYGchcew@mail.gmail.com>
References: <BANLkTi=j1FwEv2tBmPck3GWHWgcYGchcew@mail.gmail.com>
Date: Wed, 29 Jun 2011 11:35:38 -0700
Message-ID: <BANLkTim68z1Q6TEhYe_mvFaEig2e6B8miQ@mail.gmail.com>
Subject: Re: perf_event_open system call support in powerpc
From: ashwath narasimhan <ashwath.narasimhan@oneconvergence.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0050450145380bf87504a6de0dd2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0050450145380bf87504a6de0dd2
Content-Type: text/plain; charset=ISO-8859-1

Yep e500mc supports performance counters in hardware. Found the mapping for
the kernel call in /arch/powerpc/include/asm/systbl.h

On Tue, Jun 28, 2011 at 8:03 PM, ashwath narasimhan <
ashwath.narasimhan@oneconvergence.com> wrote:

> Hello,
>
>  I am new to the powerpc architecture and I am trying to use
> perf_event_open() system call for power pc architecture (e500mc) using
> 2.6.32 kernel distribution. Is this system call number supported for power
> pc architecture? If yes, is there something similar to
>  arch/x86/kernel/syscall_table_32.S  listing for powerpc that indicates the
> number for the above system call?
>
> Thanks in advance for assisting me. Please email me at
> ashwath.narasimhan@oneconvergence.com
>
> --
> -Ash
>



-- 
-Ash

--0050450145380bf87504a6de0dd2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yep e500mc supports performance counters in hardware. Found the mapping for=
 the kernel call in=A0/arch/powerpc/include/asm/systbl.h<br><br><div class=
=3D"gmail_quote">On Tue, Jun 28, 2011 at 8:03 PM, ashwath narasimhan <span =
dir=3D"ltr">&lt;<a href=3D"mailto:ashwath.narasimhan@oneconvergence.com">as=
hwath.narasimhan@oneconvergence.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Hello,<div><br></div><div>=A0I am new to th=
e powerpc architecture and I am trying to use perf_event_open() system call=
 for power pc architecture (e500mc) using 2.6.32 kernel distribution. Is th=
is system call number supported for power pc architecture? If yes, is there=
 something similar to =A0arch/x86/kernel/syscall_table_32.S =A0listing for =
powerpc that indicates the number for the above system call?</div>

<div><br></div><div>Thanks in advance for assisting me. Please email me at =
<a href=3D"mailto:ashwath.narasimhan@oneconvergence.com" target=3D"_blank">=
ashwath.narasimhan@oneconvergence.com</a><br clear=3D"all"><br>-- <br>-Ash<=
br>

</div>
</blockquote></div><br><br clear=3D"all"><br>-- <br>-Ash<br>

--0050450145380bf87504a6de0dd2--
