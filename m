Return-Path: <khushaluniversal@yahoo.com>
Received: from sonic305-20.consmr.mail.sg3.yahoo.com
 (sonic305-20.consmr.mail.sg3.yahoo.com [106.10.241.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCXJr0Px2zDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 00:49:30 +1100 (AEDT)
Date: Thu, 12 Oct 2017 13:48:55 +0000 (UTC)
From: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
Reply-To: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <444507862.763398.1507816135396@mail.yahoo.com>
Subject: Re: [PATCH V2 10/10] powerpc/mm: kasan: Add kasan support for ppc64
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_763397_2008509355.1507816135393"
References: <444507862.763398.1507816135396.ref@mail.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_763397_2008509355.1507816135393
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aneesh,
I have gone through your KASan patch for ppc64 and ported the same changes =
on my PPC platform but I am facing deadlock and terminal becomes unresponsi=
ve.I saw some false printk recursion which you have mentioned in mail chain=
. I followed all the points mentioned in your discussion and at the end bel=
ow lines from you
"I still haven't fully isolated all the .c files which should not be kasan =
instrumented. That means in case of ppc64 i ended up calling kasan _load/_s=
tore in real mode. That will result in failure w.r.t to the above spin_lock=
 code."can you please give me the list of .c files where I need to change t=
o overcome this deadlock and false printk recursion.Please help me out as I=
 am totally stuck from last 10 days and really frustrated by now.Thanking y=
ou in Advance.=C2=A0THANKS AND REGARDS,
KHUSHAL K. GUMGAONKARIIT KHARAGPUR
------=_Part_763397_2008509355.1507816135393
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:times new roman, new york, times, serif;font-size:13px"><div id=
=3D"yui_3_16_0_ym19_1_1507815689128_2038"><span id=3D"yui_3_16_0_ym19_1_150=
7815689128_5812"><font id=3D"yui_3_16_0_ym19_1_1507815689128_7521" size=3D"=
3" face=3D"Courier New, courier, monaco, monospace, sans-serif">Hi Aneesh,<=
/font></span></div><div id=3D"yui_3_16_0_ym19_1_1507815689128_2038"><span><=
font size=3D"3" face=3D"Courier New, courier, monaco, monospace, sans-serif=
"><br></font></span></div><div id=3D"yui_3_16_0_ym19_1_1507815689128_2038" =
dir=3D"ltr"><span id=3D"yui_3_16_0_ym19_1_1507815689128_2582"><font id=3D"y=
ui_3_16_0_ym19_1_1507815689128_7517" size=3D"3" face=3D"Courier New, courie=
r, monaco, monospace, sans-serif">I have gone through your KASan patch for =
ppc64 and ported the same changes on my PPC platform but I am facing deadlo=
ck and terminal becomes unresponsive.</font></span></div><div id=3D"yui_3_1=
6_0_ym19_1_1507815689128_2038" dir=3D"ltr"><span id=3D"yui_3_16_0_ym19_1_15=
07815689128_2585"><font id=3D"yui_3_16_0_ym19_1_1507815689128_7515" size=3D=
"3" face=3D"Courier New, courier, monaco, monospace, sans-serif">I saw some=
 false printk recursion which you have mentioned in mail chain. I followed =
all the points mentioned in your discussion and at the end below lines from=
 you</font></span></div><div id=3D"yui_3_16_0_ym19_1_1507815689128_2038" di=
r=3D"ltr"><span><font size=3D"3"><br></font></span></div><div id=3D"yui_3_1=
6_0_ym19_1_1507815689128_2038" dir=3D"ltr"><font size=3D"3" id=3D"yui_3_16_=
0_ym19_1_1507815689128_7518"><b id=3D"yui_3_16_0_ym19_1_1507815689128_7535"=
><span id=3D"yui_3_16_0_ym19_1_1507815689128_7524">"</span><span style=3D"f=
ont-family: &quot;Courier New&quot;; white-space: pre-wrap;" id=3D"yui_3_16=
_0_ym19_1_1507815689128_2635">I still haven't fully isolated all the .c fil=
es which should not be </span></b></font><b id=3D"yui_3_16_0_ym19_1_1507815=
689128_7534" style=3D"font-size: medium; font-family: &quot;Courier New&quo=
t;; white-space: pre-wrap;">kasan instrumented. That means in case of ppc64=
 i ended up calling </b><b id=3D"yui_3_16_0_ym19_1_1507815689128_7534" styl=
e=3D"font-size: medium; font-family: &quot;Courier New&quot;; white-space: =
pre-wrap;">kasan _load/_store in real mode. That will result in failure w.r=
.t </b><b id=3D"yui_3_16_0_ym19_1_1507815689128_7534" style=3D"font-size: m=
edium; font-family: &quot;Courier New&quot;; white-space: pre-wrap;">to the=
 above spin_lock code."</b></div><pre id=3D"yui_3_16_0_ym19_1_1507815689128=
_2636"><font size=3D"3" id=3D"yui_3_16_0_ym19_1_1507815689128_7528">can you=
 please give me the list of .c files where I need to change to overcome thi=
s deadlock and false printk recursion.</font></pre><pre id=3D"yui_3_16_0_ym=
19_1_1507815689128_2636"><font size=3D"3" id=3D"yui_3_16_0_ym19_1_150781568=
9128_7529">Please help me out as I am totally stuck from last 10 days and r=
eally frustrated by now.</font></pre><pre id=3D"yui_3_16_0_ym19_1_150781568=
9128_2636"><font size=3D"3" id=3D"yui_3_16_0_ym19_1_1507815689128_7523">Tha=
nking you in Advance.</font></pre><div></div><div id=3D"yui_3_16_0_ym19_1_1=
507815689128_2019">&nbsp;</div><div class=3D"signature" id=3D"yui_3_16_0_ym=
19_1_1507815689128_2004"><div id=3D"yui_3_16_0_ym19_1_1507815689128_2003"><=
span style=3D"font-size:16px;font-family:garamond, 'new york', times, serif=
;font-weight:bold;color:rgb(0, 0, 255);" id=3D"yui_3_16_0_ym19_1_1507815689=
128_2018">THANKS AND REGARDS,</span></div><div id=3D"yui_3_16_0_ym19_1_1507=
815689128_2005"><span style=3D"font-size:medium;font-family:garamond, 'new =
york', times, serif;font-weight:bold;color:rgb(0, 0, 255);"><br></span></di=
v><div style=3D"background-color:transparent;font-style:normal;" id=3D"yui_=
3_16_0_ym19_1_1507815689128_2007"><span style=3D"font-size:medium;font-fami=
ly:garamond, 'new york', times, serif;font-weight:bold;color:rgb(0, 0, 255)=
;" id=3D"yui_3_16_0_ym19_1_1507815689128_2006">KHUSHAL K. GUMGAONKAR</span>=
</div><div style=3D"background-color:transparent;font-style:normal;" id=3D"=
yui_3_16_0_ym19_1_1507815689128_2583"><span style=3D"font-size:16px;font-fa=
mily:garamond, 'new york', times, serif;font-weight:bold;color:rgb(0, 0, 25=
5);" id=3D"yui_3_16_0_ym19_1_1507815689128_2584">IIT KHARAGPUR</span></div>=
</div></div></body></html>
------=_Part_763397_2008509355.1507816135393--
