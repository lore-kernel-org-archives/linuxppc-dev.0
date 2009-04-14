Return-Path: <tiejun.china@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id B3757DE007
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 20:12:00 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2386981wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 03:11:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3C36E383-13A3-49E9-B87B-D22D966B6F79@kernel.crashing.org>
References: <1238755594-18869-1-git-send-email-tiejun.china@gmail.com>
	<1238755594-18869-2-git-send-email-tiejun.china@gmail.com>
	<3C36E383-13A3-49E9-B87B-D22D966B6F79@kernel.crashing.org>
Date: Tue, 14 Apr 2009 18:11:58 +0800
Message-ID: <7a800c8d0904140311q5bdb98c4t327131175d16a36d@mail.gmail.com>
Subject: Re: [v1 PATCH 1/1] Fix 64bit Maple Host Bridge Address and Size Nodes
From: Tiejun Chen <tiejun.china@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=000e0cd2de30b1673e0467810f1f
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd2de30b1673e0467810f1f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Segher,

Thank you very much for your review.

I already re-send this patch as you expect and please check this:
[v2 PATCH 1/1] Fix 64bit Maple Host Bridge 'reg' property

Best Regards
Tiejun

2009/4/14 Segher Boessenkool <segher@kernel.crashing.org>

> In the DTB tree created by firmware on some Maple 64bit targets, such as
>> ATCA6101,
>> these two properties, address&size, should be 2.
>>
>
> And they are.
>
>  But the actual corresponding values
>> of host bridge node are set 1 incorrectly by the firmware, we have to
>> provide one
>> fixup function to fix that.
>>
>
> It is the "reg" property that is incorrectly encoded as-if
> #address-cells and #size-cells were 1.
>
> Please fix the commit message (and subject line).
>
>  +       name = "/hostbridge@f8000000";
>> +       hb = call_prom("finddevice", 1, 1, ADDR(name));
>>
>
> It's interesting that the firmware can find your node this way,
> it won't match the "reg"!  Looks like there is more than one
> bug in there.
>
> Code looks good,
>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
>
>
> Segher
>
>

--000e0cd2de30b1673e0467810f1f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Segher,<br><br>Thank you very much for your review.<br><br>I already re-sen=
d this patch as you expect and please check this:<br>[v2 PATCH 1/1] Fix 64b=
it Maple Host Bridge &#39;reg&#39; property<br><br>Best Regards<br>Tiejun<b=
r>
<br><div class=3D"gmail_quote">2009/4/14 Segher Boessenkool <span dir=3D"lt=
r">&lt;<a href=3D"mailto:segher@kernel.crashing.org">segher@kernel.crashing=
.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>
In the DTB tree created by firmware on some Maple 64bit targets, such as AT=
CA6101,<br>
these two properties, address&amp;size, should be 2.<br>
</blockquote>
<br></div>
And they are.<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
But the actual corresponding values<br>
of host bridge node are set 1 incorrectly by the firmware, we have to provi=
de one<br>
fixup function to fix that.<br>
</blockquote>
<br></div>
It is the &quot;reg&quot; property that is incorrectly encoded as-if<br>
#address-cells and #size-cells were 1.<br>
<br>
Please fix the commit message (and subject line).<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
+ =A0 =A0 =A0 name =3D &quot;/hostbridge@f8000000&quot;;<br>
+ =A0 =A0 =A0 hb =3D call_prom(&quot;finddevice&quot;, 1, 1, ADDR(name));<b=
r>
</blockquote>
<br></div>
It&#39;s interesting that the firmware can find your node this way,<br>
it won&#39;t match the &quot;reg&quot;! =A0Looks like there is more than on=
e<br>
bug in there.<br>
<br>
Code looks good,<br>
<br>
Reviewed-by: Segher Boessenkool &lt;<a href=3D"mailto:segher@kernel.crashin=
g.org" target=3D"_blank">segher@kernel.crashing.org</a>&gt;<br><font color=
=3D"#888888">
<br>
<br>
Segher<br>
<br>
</font></blockquote></div><br>

--000e0cd2de30b1673e0467810f1f--
