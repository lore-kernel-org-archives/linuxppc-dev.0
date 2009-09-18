Return-Path: <gr1xmail@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id C3B57B7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Sep 2009 02:29:43 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so495851fgg.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Sep 2009 09:29:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8abf57fa0909180837sc3864bcwb0cc2cb7b211c17d@mail.gmail.com>
References: <8abf57fa0909180837sc3864bcwb0cc2cb7b211c17d@mail.gmail.com>
Date: Sat, 19 Sep 2009 00:29:40 +0800
Message-ID: <8abf57fa0909180929j418f9fb7t80a4f707b2fce4e1@mail.gmail.com>
Subject: Re: Powerpc Kernel 2.6.26.5 boot panic when call cfi_probe_chip()
From: g r1x <gr1xmail@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001485eb9dae83d49d0473dca313
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485eb9dae83d49d0473dca313
Content-Type: text/plain; charset=ISO-8859-1

2009/9/18 g r1x <gr1xmail@gmail.com>

> I'm working on a 440GX demo board with a flash chip s29gl256p(128k sector
> size, 32M total, CFI). I have tried 2 ways to add mtd partiton to the
> kernel, but failed with kernel panic. (kernel version: 2.6.26.5)
>
 S29GL256p is pin strapped as a 16bit width
so in dts, I wrote:
bank-width = <2>;
device-width = <1>;

In OF driver:
#define CFG_FLASH_BUS_WIDTH     2
struct map_info s29gl_map = {
        .name = "Nor Flash on Cerberus",
        .size = CFG_FLASH_SIZE,
        .bankwidth = CFG_FLASH_BUS_WIDTH,
};

--001485eb9dae83d49d0473dca313
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/9/18 g r1x <span dir=3D"ltr">&lt;<a href=3D=
"mailto:gr1xmail@gmail.com">gr1xmail@gmail.com</a>&gt;</span><br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex;">
I&#39;m working on a 440GX demo board with a flash chip s29gl256p(128k sect=
or size, 32M total, CFI). I have tried 2 ways to add mtd partiton to the ke=
rnel, but failed with kernel panic. (kernel version: 2.6.26.5)<div><span cl=
ass=3D"Apple-style-span" style=3D"white-space: pre; ">	</span></div>
</blockquote><div>=A0S29GL256p is pin strapped as a 16bit width</div><div>s=
o in dts, I wrote:</div><div><span class=3D"Apple-style-span" style=3D"font=
-family: arial, sans-serif; font-size: 13px; border-collapse: collapse; "><=
div>
<span style=3D"white-space: pre; ">					</span>bank-width =3D &lt;2&gt;;</d=
iv><div><span style=3D"white-space: pre; ">					</span>device-width =3D &lt=
;1&gt;;</div><div><br></div><div>In OF driver:</div><div>#define CFG_FLASH_=
BUS_WIDTH =A0 =A0 2</div>
<div><div>struct map_info s29gl_map =3D {</div><div>=A0=A0 =A0 =A0 =A0.name=
 =3D &quot;Nor Flash on Cerberus&quot;,</div><div>=A0=A0 =A0 =A0 =A0.size =
=3D CFG_FLASH_SIZE,</div><div>=A0=A0 =A0 =A0 =A0.bankwidth =3D CFG_FLASH_BU=
S_WIDTH,</div><div>};</div><div><br>
</div></div></span></div></div>

--001485eb9dae83d49d0473dca313--
