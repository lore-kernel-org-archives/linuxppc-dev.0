Return-Path: <shlimeng@cn.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2q7z69BjzDsQg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 19:26:39 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8S9QZOK096346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 05:26:37 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.90])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d8s38qsqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 05:26:36 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <shlimeng@cn.ibm.com>;
 Thu, 28 Sep 2017 09:24:57 -0000
Subject: Re: [PATCH] powerpc/powernv: Use early_radix_enabled in POWER9 tlb
 flush
In-Reply-To: <20170927054558.26007-1-npiggin@gmail.com>
From: "Meng YK Li" <shlimeng@cn.ibm.com>
To: npiggin@gmail.com
Cc: jk@ozlabs.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 "Frank J Yu" <jiangyu@cn.ibm.com>
Date: Thu, 28 Sep 2017 09:24:53 +0000
MIME-Version: 1.0
References: <20170927054558.26007-1-npiggin@gmail.com>
Content-Type: text/html; charset=UTF-8
Message-Id: <OF23A48077.422D2246-ON002581A9.0033193F-002581A9.0033B7CC@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, H=
elvetica, sans-serif;font-size:10.5pt" ><div dir=3D"ltr" ><span style=3D"fo=
nt-size:0.857em;" >Nick,</span></div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" ><span style=3D"font-size:0.857em;" >I applied your patch =
into linux kernel 4.13, rebuild it, installed it, then had a test, still ca=
n not boot OS. System hung here, the same as before.</span></div>
<div dir=3D"ltr" ><span style=3D"font-size:0.857em;" >Would you please have=
 a look?</span></div>
<div dir=3D"ltr" ><span style=3D"font-size:0.714em;" >The system is going d=
own NOW!<br>Sent SIGTERM to all processes<br>Sent SIGKILL to all processes<=
br>[&nbsp; 104.755810] kexec=5Fcore: Starting new kernel<br>[&nbsp; 126.157=
029744,5] OPAL: Switch to big-endian OS</span></div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" ><div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"fo=
nt-family:Arial, Helvetica, sans-serif;font-size:10.5pt" ><div class=3D"soc=
maildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, Helvetica, sans-se=
rif;font-size:10.5pt" ><div class=3D"socmaildefaultfont" dir=3D"ltr" style=
=3D"font-family:Arial, Helvetica, sans-serif;font-size:10.5pt" ><div dir=3D=
"ltr" ><span style=3D"font-size:0.857em;" ><font face=3D"Default Sans Serif=
,Verdana,Arial,Helvetica,sans-serif" ><i>Best Regards!<br>Meng Li<br>IBM Op=
enPOWER Application Engineer</i></font></span></div></div></div></div></div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<blockquote data-history-content-modified=3D"1" dir=3D"ltr" style=3D"border=
-left:solid #aaaaaa 2px; margin-left:5px; padding-left:5px; direction:ltr; =
margin-right:0px" >----- Original message -----<br>From: Nicholas Piggin &l=
t;npiggin@gmail.com&gt;<br>To: linuxppc-dev@lists.ozlabs.org<br>Cc: Nichola=
s Piggin &lt;npiggin@gmail.com&gt;, Jeremy Kerr &lt;jk@ozlabs.org&gt;, Meng=
 YK Li &lt;shlimeng@cn.ibm.com&gt;<br>Subject: [PATCH] powerpc/powernv: Use=
 early=5Fradix=5Fenabled in POWER9 tlb flush<br>Date: Wed, Sep 27, 2017 1:4=
6 PM<br>&nbsp;
<div><font size=3D"2" face=3D"Default Monospace,Courier New,Courier,monospa=
ce" >This code is used at boot and machine checks, so it should be using<br=
>early=5Fradix=5Fenabled() (which is usable any time).<br><br>Signed-off-by=
: Nicholas Piggin &lt;npiggin@gmail.com&gt;<br>---<br>&nbsp;arch/powerpc/ke=
rnel/mce=5Fpower.c | 2 +-<br>&nbsp;1 file changed, 1 insertion(+), 1 deleti=
on(-)<br><br>diff --git a/arch/powerpc/kernel/mce=5Fpower.c b/arch/powerpc/=
kernel/mce=5Fpower.c<br>index b76ca198e09c..d37e612050b5 100644<br>--- a/ar=
ch/powerpc/kernel/mce=5Fpower.c<br>+++ b/arch/powerpc/kernel/mce=5Fpower.c<=
br>@@ -128,7 +128,7 @@ void =5F=5Fflush=5Ftlb=5Fpower9(unsigned int action)=
<br>&nbsp;{<br>&nbsp; unsigned int num=5Fsets;<br>&nbsp;<br>- if (radix=5Fe=
nabled())<br>+ if (early=5Fradix=5Fenabled())<br>&nbsp; num=5Fsets =3D POWE=
R9=5FTLB=5FSETS=5FRADIX;<br>&nbsp; else<br>&nbsp; num=5Fsets =3D POWER9=5FT=
LB=5FSETS=5FHASH;<br>--<br>2.13.3</font><br>&nbsp;</div></blockquote>
<div dir=3D"ltr" >&nbsp;</div></div><BR>
