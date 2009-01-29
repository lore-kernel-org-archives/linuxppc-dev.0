Return-Path: <bms.monteiro@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 3CDD8DE0B0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:16:50 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so64685ele.3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 12:16:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <498208E0.7000707@trimble.com>
References: <498208E0.7000707@trimble.com>
Date: Thu, 29 Jan 2009 20:16:47 +0000
Message-ID: <d43ae5a00901291216i81af684le53e534533b9c4b2@mail.gmail.com>
Subject: Re: toolchain for building linux-2.6.27.8 or 2.6.28.1 ...
From: Bruno Monteiro <bms.monteiro@gmail.com>
To: mike_timmons@trimble.com
Content-Type: multipart/alternative; boundary=000e0cd1a1fc985c420461a4c4b2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd1a1fc985c420461a4c4b2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Mike,

For cross compile issue you should try
crosstool-ng<http://ymorin.is-a-geek.org/dokuwiki/projects/crosstool>.
It works fine with ppc 405.

Regards,
Bruno


On Thu, Jan 29, 2009 at 7:52 PM, Mike Timmons <mike_timmons@trimble.com>wrote:

> I wrote a couple days ago needing advice on USB wi fi. I made some progress
> but then I hit a snag loading the USB wi fi adapter firmware.
>
> Jon schooled me on the firmware topic (thanks Jon), and advised me to
> select the following Kconfig options
>
> Kconfig
> Device drivers
>  generic driver options
>    user space firmware support
>       check - include in-kernel firmware blobs in kernel binary
>
>
> My 2.6.24 kernel didn't offer these options, and I also suspected that
> since 2.6.24 some progress on the ralink drivers I need has been made I
> figured I'd just try a new kernel build and try to get my ralink-equipped
> Linksys WUSB54GC to work.
>
> Trouble:
> -I was using  Ltib Toolchain (gcc-3.4.3-glibc-2.3.6 (for 603e)) to build my
> 2.6.24 kernel.
> -It looks like somewhere after 2.6.24 this toolchain stopped successfully
> compiling the kernel.
>
> So,
> -I used crosstool and built 4.1.0 and 4.1.1 toolchains. Both produce the
> following error:
>
>  OBJCOPY arch/powerpc/kernel/vdso32/vdso32.so
> objcopy: Unable to recognise the format of the input file
> `arch/powerpc/kernel/vdso32/vdso32.so.dbg'
> make[3]: *** [arch/powerpc/kernel/vdso32/vdso32.so] Error 1
> make[2]: *** [arch/powerpc/kernel/vdso32] Error 2
>
>
> Questions:
> 1) if I want to cross-compile a kernel later than 2.6.24 to hopefully get
> better WAN device support (and clearer options for fw loading), which kernel
> should I try, and which toolchain?
>
> the ltib repository does not appear to have a toolchain newer than
>  gcc-3.4.3-glibc-2.3.6 (for 603e)
>
> Admissions, disclaimers, etc
> 1) I'm using the same ltib script I have used for the 2.6.24 build with
> toolchain gcc-3.4.3-glibc-2.3.6 (for 603e).
> I'm simply modifying the kernel spec file to use 2.6.28.1 (and specifyin a
> custom toolchain).
> I've also tried to compile 2.6.27.8. I get the same error.
>
>
> I think I'm slipping into version compatibility hell at this point. Please
> throw me a rope if you can by way of advice if you can.
>
> Thanks!
>
> -Mike
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

--000e0cd1a1fc985c420461a4c4b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mike,<br><br>For cross compile issue you should try <a href=3D"http://ym=
orin.is-a-geek.org/dokuwiki/projects/crosstool">crosstool-ng</a>. It works =
fine with ppc 405.<br><br>Regards,<br>Bruno<br><br><br><div class=3D"gmail_=
quote">
On Thu, Jan 29, 2009 at 7:52 PM, Mike Timmons <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mike_timmons@trimble.com">mike_timmons@trimble.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I wrote a couple days ago needing advice on USB wi fi. I made some progress=
 but then I hit a snag loading the USB wi fi adapter firmware.<br>
<br>
Jon schooled me on the firmware topic (thanks Jon), and advised me to selec=
t the following Kconfig options<br>
<br>
Kconfig<br>
Device drivers<br>
&nbsp;generic driver options<br>
 &nbsp; &nbsp;user space firmware support<br>
 &nbsp; &nbsp; &nbsp; check - include in-kernel firmware blobs in kernel bi=
nary<br>
<br>
<br>
My 2.6.24 kernel didn&#39;t offer these options, and I also suspected that =
since 2.6.24 some progress on the ralink drivers I need has been made I fig=
ured I&#39;d just try a new kernel build and try to get my ralink-equipped =
Linksys WUSB54GC to work.<br>

<br>
Trouble:<br>
-I was using &nbsp;Ltib Toolchain (gcc-3.4.3-glibc-2.3.6 (for 603e)) to bui=
ld my 2.6.24 kernel.<br>
-It looks like somewhere after 2.6.24 this toolchain stopped successfully c=
ompiling the kernel.<br>
<br>
So,<br>
-I used crosstool and built 4.1.0 and 4.1.1 toolchains. Both produce the fo=
llowing error:<br>
<br>
&nbsp;OBJCOPY arch/powerpc/kernel/vdso32/vdso32.so<br>
objcopy: Unable to recognise the format of the input file `arch/powerpc/ker=
nel/vdso32/vdso32.so.dbg&#39;<br>
make[3]: *** [arch/powerpc/kernel/vdso32/vdso32.so] Error 1<br>
make[2]: *** [arch/powerpc/kernel/vdso32] Error 2<br>
<br>
<br>
Questions:<br>
1) if I want to cross-compile a kernel later than 2.6.24 to hopefully get b=
etter WAN device support (and clearer options for fw loading), which kernel=
 should I try, and which toolchain?<br>
<br>
the ltib repository does not appear to have a toolchain newer than &nbsp;gc=
c-3.4.3-glibc-2.3.6 (for 603e)<br>
<br>
Admissions, disclaimers, etc<br>
1) I&#39;m using the same ltib script I have used for the 2.6.24 build with=
 toolchain gcc-3.4.3-glibc-2.3.6 (for 603e).<br>
I&#39;m simply modifying the kernel spec file to use 2.6.28.1 (and specifyi=
n a custom toolchain).<br>
I&#39;ve also tried to compile 2.6.27.8. I get the same error.<br>
<br>
<br>
I think I&#39;m slipping into version compatibility hell at this point. Ple=
ase throw me a rope if you can by way of advice if you can.<br>
<br>
Thanks!<br>
<br>
-Mike<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org" target=3D"_blank">Linuxppc-dev@o=
zlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--000e0cd1a1fc985c420461a4c4b2--
