Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2C2F3B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 02:32:30 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <578FBC09-589D-4691-82FF-985FCFE8ADC9@kernel.crashing.org>
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
	<2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
	<6213bc560907220838h49e5c273qa543e538bb37923a@mail.gmail.com>
	<578FBC09-589D-4691-82FF-985FCFE8ADC9@kernel.crashing.org>
Date: Wed, 22 Jul 2009 22:02:27 +0530
Message-ID: <6213bc560907220932u3b771af2q743ae55dda5a2198@mail.gmail.com>
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=000e0cd2a0a8b771d6046f4dea8e
Cc: Linuxppc-dev@ozlabs.org, Ltp-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd2a0a8b771d6046f4dea8e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 22, 2009 at 9:14 PM, Kumar Gala <galak@kernel.crashing.org>wrote:

>
> On Jul 22, 2009, at 10:38 AM, srikanth krishnakar wrote:
>
>
>>
>> On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala <galak@kernel.crashing.org>
>> wrote:
>> I'm not seeing any BUG* in traps.c @ line 904.
>>
>>
>> On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:
>>
>> The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC
>> architecture (ppc440)
>>
>>
>> msgctl10    1  B------------[ cut here ]------------
>> kernel BUG at arch/powerpc/kernel/traps.c:904!
>> Oops: Exception in kernel mode, sig: 5 [#9]
>>
>> I'm not seeing any BUG* in traps.c @ line 904.  Do you have some other
>> patches on top of 2.6.29.6?
>>
>> - k
>>
>>
>> I have LTTng patches on top of linux-2.6.29.6.
>>
>
> Does it modify traps.c?  Can you see what the code around line 904 looks
> like and post that.
>
> - k
>
 896
 897 #if defined(CONFIG_XILINX_VIRTEX_5_FXT) && defined(CONFIG_PPC_FPU)
 898         if (reason & REASON_ILLEGAL) {
 899                 if (excep_state < 1) {
 900                         excep_state++;
 901                         return;
 902                 }
 903                 /* should never get here */
 904                 BUG();
 905         }
 906 #endif
 907
 908         /* Try to emulate it if we should. */


-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--000e0cd2a0a8b771d6046f4dea8e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 22, 2009 at 9:14 PM, Kumar G=
ala <span dir=3D"ltr">&lt;<a href=3D"mailto:galak@kernel.crashing.org">gala=
k@kernel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
On Jul 22, 2009, at 10:38 AM, srikanth krishnakar wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala &lt;<a href=3D"mailto:galak@ker=
nel.crashing.org" target=3D"_blank">galak@kernel.crashing.org</a>&gt; wrote=
:<br>
I&#39;m not seeing any BUG* in traps.c @ line 904.<br>
<br>
<br>
On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:<br>
<br>
The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC architectu=
re (ppc440)<br>
<br>
<br>
msgctl10 =A0 =A01 =A0B------------[ cut here ]------------<br>
kernel BUG at arch/powerpc/kernel/traps.c:904!<br>
Oops: Exception in kernel mode, sig: 5 [#9]<br>
<br>
I&#39;m not seeing any BUG* in traps.c @ line 904. =A0Do you have some othe=
r patches on top of 2.6.29.6?<br>
<br>
- k<br>
<br>
<br>
I have LTTng patches on top of linux-2.6.29.6.<br>
</blockquote>
<br></div>
Does it modify traps.c? =A0Can you see what the code around line 904 looks =
like and post that.<br><font color=3D"#888888">
<br>
- k<br>
</font></blockquote></div>=A0896<br>=A0897 #if defined(CONFIG_XILINX_VIRTEX=
_5_FXT) &amp;&amp; defined(CONFIG_PPC_FPU)<br>=A0898=A0=A0=A0=A0=A0=A0=A0=
=A0 if (reason &amp; REASON_ILLEGAL) {<br>=A0899=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 if (excep_state &lt; 1) {<br>=A0900=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 excep_state++;<br>
=A0901=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 return;<br>=A0902=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<br>=
=A0903=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* should never get =
here */<br>=A0904=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUG();<br=
>=A0905=A0=A0=A0=A0=A0=A0=A0=A0 }<br>=A0906 #endif<br>=A0907<br>=A0908=A0=
=A0=A0=A0=A0=A0=A0=A0 /* Try to emulate it if we should. */<br>
<br><br>-- <br>&quot;The Good You Do, The Best You GET&quot;<br><br>Regards=
<br>Srikanth Krishnakar<br>**********************<br>

--000e0cd2a0a8b771d6046f4dea8e--
