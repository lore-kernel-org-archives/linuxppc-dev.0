Return-Path: <khushaluniversal@yahoo.com>
Received: from sonic303-22.consmr.mail.sg3.yahoo.com
 (sonic303-22.consmr.mail.sg3.yahoo.com [106.10.242.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCt7f5tT2zDrD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 14:12:44 +1100 (AEDT)
Date: Fri, 13 Oct 2017 03:12:28 +0000 (UTC)
From: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
Reply-To: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <87114453.1013977.1507864348066@mail.yahoo.com>
In-Reply-To: <CAKTCnznqZ5YgWeU+x61vJtrTQnmC3-i30V+m8G42hWojpM5k0A@mail.gmail.com>
References: <962487416.5821059.1507639866584.ref@mail.yahoo.com>
 <962487416.5821059.1507639866584@mail.yahoo.com>
 <CAKTCnznqZ5YgWeU+x61vJtrTQnmC3-i30V+m8G42hWojpM5k0A@mail.gmail.com>
Subject: Re: KASan for powerpc
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_1013976_1037443293.1507864348064"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_1013976_1037443293.1507864348064
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Balbir,sorry for not mentioning details.
below are the details1. What machine you tried this on?=C2=A0 =C2=A0 - I am=
 using PowerPC e500mc processor with and it's customised. Can't share much =
details
2. What MMU mode?=C2=A0 =C2=A0 -Not sure about this.
3. What kernel?=C2=A0 =C2=A0 -kernel version is 4.1.35
4. What gcc version, flags for KASAN=C2=A0 =C2=A0 -gcc version 4.9.2 and KA=
SAN_MINIMAL FLAG=C2=A0
5. What was the KASAN design - how much shadow memory to real memory?
=C2=A0 =C2=A0 -we have continuous 2 GB=C2=A0 low memory and shadow size is =
256 MB


=C2=A0THANKS AND REGARDS,
KHUSHAL K. GUMGAONKARM.TECH IN VISUAL INFORMATION AND EMBEDDED SYSTEM,IIT K=
HARAGPUR=20

    On Friday, 13 October 2017 4:45 AM, Balbir Singh <bsingharora@gmail.com=
> wrote:
=20

 On Tue, Oct 10, 2017 at 11:51 PM, KHUSHAL GUMGAONKAR
<khushaluniversal@yahoo.com> wrote:
>=C2=A0 Hi Aneesh,
>
> I am facing unknown error in printk=C2=A0 during boot and after that kern=
el Hangs
> on powerpc with KASan changes.
>

This is probably the worst way to reach out. The reason being

You describe the crash your seeing, there is no description of

1. What machine you tried this on?
2. What MMU mode?
3. What kernel?
4. What gcc version, flags for KASAN
5. What was the KASAN design - how much shadow memory to real memory?

Unless you can work out those details, this is just noise on the list.
I posted an RFC for radix -
http://linuxppc.10917.n7.nabble.com/RFC-PATCH-v1-powerpc-radix-kasan-KASAN-=
support-for-Radix-td125864.html

It needs work, please read the implementations so far, discuss your
design/understanding. Then we can discuss what issues you are running
into, otherwise it's just noise without effort.

Balbir Singh.


  =20
------=_Part_1013976_1037443293.1507864348064
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:times new roman, new york, times, serif;font-size:13px"><div id=
=3D"yui_3_16_0_ym19_1_1507862290271_5948"><span>Hi Balbir,</span></div><div=
 id=3D"yui_3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr"><span id=3D"yui_3_=
16_0_ym19_1_1507862290271_16317">sorry for not mentioning details.</span></=
div><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948"><span><br></span></div=
><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948">below are the details</di=
v><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr"><span style=
=3D"font-family: &quot;Helvetica Neue&quot;, &quot;Segoe UI&quot;, Helvetic=
a, Arial, &quot;Lucida Grande&quot;, sans-serif;" id=3D"yui_3_16_0_ym19_1_1=
507862290271_6064">1. What machine you tried this on?</span></div><div id=
=3D"yui_3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr">&nbsp; &nbsp; - I am =
using PowerPC e500mc processor with and it's customised. Can't share much d=
etails<br clear=3D"none" style=3D"font-family: &quot;Helvetica Neue&quot;, =
&quot;Segoe UI&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-ser=
if;" id=3D"yui_3_16_0_ym19_1_1507862290271_6065"><span style=3D"font-family=
: &quot;Helvetica Neue&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, &quot=
;Lucida Grande&quot;, sans-serif;" id=3D"yui_3_16_0_ym19_1_1507862290271_60=
66">2. What MMU mode?</span></div><div id=3D"yui_3_16_0_ym19_1_150786229027=
1_5948" dir=3D"ltr">&nbsp; &nbsp; -Not sure about this.<br clear=3D"none" s=
tyle=3D"font-family: &quot;Helvetica Neue&quot;, &quot;Segoe UI&quot;, Helv=
etica, Arial, &quot;Lucida Grande&quot;, sans-serif;" id=3D"yui_3_16_0_ym19=
_1_1507862290271_6067"><span style=3D"font-family: &quot;Helvetica Neue&quo=
t;, &quot;Segoe UI&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans=
-serif;" id=3D"yui_3_16_0_ym19_1_1507862290271_6068">3. What kernel?</span>=
</div><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr">&nbsp; &=
nbsp; -kernel version is 4.1.35<br clear=3D"none" style=3D"font-family: &qu=
ot;Helvetica Neue&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, &quot;Luci=
da Grande&quot;, sans-serif;" id=3D"yui_3_16_0_ym19_1_1507862290271_6069"><=
span style=3D"font-family: &quot;Helvetica Neue&quot;, &quot;Segoe UI&quot;=
, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif;" id=3D"yui_3_16_=
0_ym19_1_1507862290271_6070">4. What gcc version, flags for KASAN</span></d=
iv><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr">&nbsp; &nbs=
p; -gcc version 4.9.2 and KASAN_MINIMAL FLAG&nbsp;<br clear=3D"none" style=
=3D"font-family: &quot;Helvetica Neue&quot;, &quot;Segoe UI&quot;, Helvetic=
a, Arial, &quot;Lucida Grande&quot;, sans-serif;" id=3D"yui_3_16_0_ym19_1_1=
507862290271_6071"><span style=3D"font-family: &quot;Helvetica Neue&quot;, =
&quot;Segoe UI&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-ser=
if;" id=3D"yui_3_16_0_ym19_1_1507862290271_6072">5. What was the KASAN desi=
gn - how much shadow memory to real memory?</span><br></div><div id=3D"yui_=
3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr"><span style=3D"font-family: &=
quot;Helvetica Neue&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, &quot;Lu=
cida Grande&quot;, sans-serif;" id=3D"yui_3_16_0_ym19_1_1507862290271_12802=
">&nbsp; &nbsp; -we have continuous 2 GB&nbsp; low memory and shadow size i=
s 256 MB<br></span></div><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948" d=
ir=3D"ltr"><span style=3D"font-family: &quot;Helvetica Neue&quot;, &quot;Se=
goe UI&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif;"><br=
></span></div><div id=3D"yui_3_16_0_ym19_1_1507862290271_5948" dir=3D"ltr">=
<span style=3D"font-family: &quot;Helvetica Neue&quot;, &quot;Segoe UI&quot=
;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif;"><br></span></d=
iv><div></div><div id=3D"yui_3_16_0_ym19_1_1507862290271_6014">&nbsp;</div>=
<div class=3D"signature" id=3D"yui_3_16_0_ym19_1_1507862290271_6008"><div i=
d=3D"yui_3_16_0_ym19_1_1507862290271_6007"><span style=3D"font-size:16px;fo=
nt-family:garamond, 'new york', times, serif;font-weight:bold;color:rgb(0, =
0, 255);" id=3D"yui_3_16_0_ym19_1_1507862290271_6006">THANKS AND REGARDS,</=
span></div><div id=3D"yui_3_16_0_ym19_1_1507862290271_6013"><span style=3D"=
font-size:medium;font-family:garamond, 'new york', times, serif;font-weight=
:bold;color:rgb(0, 0, 255);"><br></span></div><div style=3D"background-colo=
r:transparent;font-style:normal;" id=3D"yui_3_16_0_ym19_1_1507862290271_601=
2"><span style=3D"font-size:medium;font-family:garamond, 'new york', times,=
 serif;font-weight:bold;color:rgb(0, 0, 255);" id=3D"yui_3_16_0_ym19_1_1507=
862290271_6011">KHUSHAL K. GUMGAONKAR</span></div><div style=3D"background-=
color:transparent;font-style:normal;" id=3D"yui_3_16_0_ym19_1_1507862290271=
_6010"><span style=3D"font-size:medium;font-family:garamond, 'new york', ti=
mes, serif;font-weight:bold;color:rgb(0, 0, 255);" id=3D"yui_3_16_0_ym19_1_=
1507862290271_6009">M.TECH IN VISUAL INFORMATION AND EMBEDDED SYSTEM,</span=
></div><div style=3D"background-color:transparent;font-style:normal;" id=3D=
"yui_3_16_0_ym19_1_1507862290271_14523"><span style=3D"font-size:16px;font-=
family:garamond, 'new york', times, serif;font-weight:bold;color:rgb(0, 0, =
255);" id=3D"yui_3_16_0_ym19_1_1507862290271_19665">IIT KHARAGPUR</span></d=
iv></div> <div class=3D"qtdSeparateBR"><br><br></div><div class=3D"yahoo_qu=
oted" style=3D"display: block;"> <div style=3D"font-family: times new roman=
, new york, times, serif; font-size: 13px;"> <div style=3D"font-family: Hel=
veticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif; fo=
nt-size: 16px;"> <div dir=3D"ltr"><font size=3D"2" face=3D"Arial"> On Frida=
y, 13 October 2017 4:45 AM, Balbir Singh &lt;bsingharora@gmail.com&gt; wrot=
e:<br></font></div>  <br><br> <div class=3D"y_msg_container"><div dir=3D"lt=
r">On Tue, Oct 10, 2017 at 11:51 PM, KHUSHAL GUMGAONKAR<div class=3D"yqt202=
6373896" id=3D"yqtfd59941"><br clear=3D"none">&lt;<a shape=3D"rect" ymailto=
=3D"mailto:khushaluniversal@yahoo.com" href=3D"mailto:khushaluniversal@yaho=
o.com">khushaluniversal@yahoo.com</a>&gt; wrote:<br clear=3D"none">&gt;&nbs=
p; Hi Aneesh,<br clear=3D"none">&gt;<br clear=3D"none">&gt; I am facing unk=
nown error in printk&nbsp; during boot and after that kernel Hangs<br clear=
=3D"none">&gt; on powerpc with KASan changes.</div><br clear=3D"none">&gt;<=
br clear=3D"none"><br clear=3D"none">This is probably the worst way to reac=
h out. The reason being<br clear=3D"none"><br clear=3D"none">You describe t=
he crash your seeing, there is no description of<br clear=3D"none"><br clea=
r=3D"none">1. What machine you tried this on?<br clear=3D"none">2. What MMU=
 mode?<br clear=3D"none">3. What kernel?<br clear=3D"none">4. What gcc vers=
ion, flags for KASAN<br clear=3D"none">5. What was the KASAN design - how m=
uch shadow memory to real memory?<br clear=3D"none"><br clear=3D"none">Unle=
ss you can work out those details, this is just noise on the list.<br clear=
=3D"none">I posted an RFC for radix -<br clear=3D"none"><a shape=3D"rect" h=
ref=3D"http://linuxppc.10917.n7.nabble.com/RFC-PATCH-v1-powerpc-radix-kasan=
-KASAN-support-for-Radix-td125864.html" target=3D"_blank">http://linuxppc.1=
0917.n7.nabble.com/RFC-PATCH-v1-powerpc-radix-kasan-KASAN-support-for-Radix=
-td125864.html</a><br clear=3D"none"><br clear=3D"none">It needs work, plea=
se read the implementations so far, discuss your<br clear=3D"none">design/u=
nderstanding. Then we can discuss what issues you are running<br clear=3D"n=
one">into, otherwise it's just noise without effort.<br clear=3D"none"><br =
clear=3D"none">Balbir Singh.<div class=3D"yqt2026373896" id=3D"yqtfd42643">=
<br clear=3D"none"></div></div><br><br></div>  </div> </div>  </div></div><=
/body></html>
------=_Part_1013976_1037443293.1507864348064--
