Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C710FB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 01:38:37 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
	<2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
Date: Wed, 22 Jul 2009 21:08:35 +0530
Message-ID: <6213bc560907220838h49e5c273qa543e538bb37923a@mail.gmail.com>
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=000e0cd30470111c18046f4d2ae3
Cc: Linuxppc-dev@ozlabs.org, Ltp-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd30470111c18046f4d2ae3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala <galak@kernel.crashing.org>wrote:

> I'm not seeing any BUG* in traps.c @ line 904.
>
> On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:
>
>  The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC
>> architecture (ppc440)
>>
>>
>> msgctl10    1  B------------[ cut here ]------------
>> kernel BUG at arch/powerpc/kernel/traps.c:904!
>> Oops: Exception in kernel mode, sig: 5 [#9]
>>
>
> I'm not seeing any BUG* in traps.c @ line 904.  Do you have some other
> patches on top of 2.6.29.6?
>
> - k
>
>
I have LTTng patches on top of linux-2.6.29.6.

-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--000e0cd30470111c18046f4d2ae3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 22, 2009 at 8:52 PM, Kumar G=
ala <span dir=3D"ltr">&lt;<a href=3D"mailto:galak@kernel.crashing.org">gala=
k@kernel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
I&#39;m not seeing any BUG* in traps.c @ line 904.<div class=3D"im"><br>
<br>
On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC architectu=
re (ppc440)<br>
<br>
<br>
msgctl10 =A0 =A01 =A0B------------[ cut here ]------------<br>
kernel BUG at arch/powerpc/kernel/traps.c:904!<br>
Oops: Exception in kernel mode, sig: 5 [#9]<br>
</blockquote>
<br></div>
I&#39;m not seeing any BUG* in traps.c @ line 904. =A0Do you have some othe=
r patches on top of 2.6.29.6?<br><font color=3D"#888888">
<br>
- k<br>
<br>
</font></blockquote></div><br>I have LTTng patches on top of linux-2.6.29.6=
.<br clear=3D"all"><br>-- <br>&quot;The Good You Do, The Best You GET&quot;=
<br><br>Regards<br>Srikanth Krishnakar<br>**********************<br>

--000e0cd30470111c18046f4d2ae3--
