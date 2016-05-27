Return-Path: <jwalthour@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGRC458hDzDqbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 23:08:00 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jwalthour@us.ibm.com>;
 Fri, 27 May 2016 07:07:56 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 142D41FF004C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 07:07:38 -0600 (MDT)
Received: from b01ledav03.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4RD7r1D38993966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 13:07:53 GMT
Received: from b01ledav03.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17CD1B2046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 09:07:53 -0400 (EDT)
Received: from d50lp03.ny.us.ibm.com (unknown [146.89.104.211])
 by b01ledav03.gho.pok.ibm.com (Postfix) with ESMTPS id 0CCFBB204E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 09:07:53 -0400 (EDT)
Received: from localhost
 by d50lp03.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jwalthour@us.ibm.com>;
 Fri, 27 May 2016 09:07:52 -0400
Received: from /spool/local
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <jwalthour@us.ibm.com>;
 Fri, 27 May 2016 13:07:45 -0000
Subject: Re: [PATCH] cxl: Abstract the differences between the PSL and XSL
In-Reply-To: <57484202.1050603@linux.vnet.ibm.com>
From: "John W Walthour" <jwalthour@us.ibm.com>
To: fbarrat@linux.vnet.ibm.com
Cc: frederic.barrat@fr.ibm.com, huyn@mellanox.com, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, mpe@ellerman.id.au
Date: Fri, 27 May 2016 13:06:59 +0000
MIME-Version: 1.0
References: <57484202.1050603@linux.vnet.ibm.com>,
 <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/html; charset=UTF-8
Message-Id: <20160527130753.0CCFBB204E@b01ledav03.gho.pok.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial;fo=
nt-size:10.5pt" ><div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Those come from
<div>XSL=5Fdatabook=5F09=5FJune=5F2014.pdf</div>
<div>&nbsp;</div>
<div>The registers in this doc listed at 0x400-600 are offset by 0x400, so =
0x568 =3D 0x168.</div>&nbsp;

<div>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2" >John Walthour</font><br><i><font face=
=3D"Courier New" color=3D"#808080" size=3D"2" >Development Engineer<br>IBM =
Corporation | Systems &amp; Technology Group</font></i><br><i><font face=3D=
"Courier New" color=3D"#808080" size=3D"2" >Phone: (512) 973-1095 | T/L: 36=
3-1095<br>Email: </font></i><a href=3D"mailto:jwalthour@us.ibm.com" ><i><u>=
<font face=3D"Courier New" color=3D"#0000FF" size=3D"2" >jwalthour@us.ibm.c=
om</font></u></i></a><br><br><i><font face=3D"Courier New" color=3D"#808080=
" size=3D"2" >return 0</font></i>
<div>&nbsp;</div>
<div>&nbsp;</div>
<blockquote data-history-content-modified=3D"1" style=3D"border-left:solid =
#aaaaaa 2px; margin-left:5px; padding-left:5px; direction:ltr; margin-right=
:0px" >----- Original message -----<br>From: Frederic Barrat &lt;fbarrat@li=
nux.vnet.ibm.com&gt;<br>Sent by: "Linuxppc-dev" &lt;linuxppc-dev-bounces+jw=
althour=3Dus.ibm.com@lists.ozlabs.org&gt;<br>To: Ian Munsie &lt;imunsie@au1=
.ibm.com&gt;, Michael Ellerman &lt;mpe@ellerman.id.au&gt;, mikey &lt;mikey@=
neuling.org&gt;, linuxppc-dev@lists.ozlabs.org, Frederic Barrat &lt;frederi=
c.barrat@fr.ibm.com&gt;, Huy Nguyen &lt;huyn@mellanox.com&gt;<br>Cc:<br>Sub=
ject: Re: [PATCH] cxl: Abstract the differences between the PSL and XSL<br>=
Date: Fri, May 27, 2016 7:49 AM<br>&nbsp;
<div><font face=3D"Default Monospace,Courier New,Courier,monospace" size=3D=
"2" >Hi Ian,<br><br>It looks good, just one question:<br><br>&gt; +/* XSL r=
egisters (Mellanox CX4) */<br>&gt; +static const cxl=5Fp1=5Freg=5Ft CXL=5FX=
SL=5FTimebase &nbsp;=3D {0x0100};<br>&gt; +static const cxl=5Fp1=5Freg=5Ft =
CXL=5FXSL=5FTB=5FCTLSTAT =3D {0x0108};<br>&gt; +static const cxl=5Fp1=5Freg=
=5Ft CXL=5FXSL=5FFEC &nbsp; &nbsp; &nbsp; =3D {0x0158};<br>&gt; +static con=
st cxl=5Fp1=5Freg=5Ft CXL=5FXSL=5FDSNCTL &nbsp; &nbsp;=3D {0x0168};<br><br>=
Out of curiosity, in which document did you get those offsets from? I<br>re=
member there used to be some confusion about it. All I could find was<br>th=
e internal offsets the firmware remaps those to (in xsl databook).<br><br>F=
eel free to grab the "From:", since the patch has evolved since I<br>worked=
 on it. I don't care.<br><br>&nbsp;&nbsp; Fred<br><br>=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>Linuxppc-dev mailing list<=
br>Linuxppc-dev@lists.ozlabs.org<br><a href=3D"https://lists.ozlabs.org/lis=
tinfo/linuxppc-dev" target=3D"=5Fblank" >https://lists.ozlabs.org/listinfo/=
linuxppc-dev</a></font></div></blockquote></div></div></div><BR>
