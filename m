Return-Path: <khushaluniversal@yahoo.com>
Received: from sonic309-46.consmr.mail.sg3.yahoo.com
 (sonic309-46.consmr.mail.sg3.yahoo.com [106.10.244.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBHC94MstzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 23:55:16 +1100 (AEDT)
Date: Tue, 10 Oct 2017 12:51:06 +0000 (UTC)
From: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
Reply-To: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <962487416.5821059.1507639866584@mail.yahoo.com>
Subject: KASan for powerpc
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_5821058_1968557856.1507639866582"
References: <962487416.5821059.1507639866584.ref@mail.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_5821058_1968557856.1507639866582
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C2=A0Hi Aneesh,
I am facing unknown error in printk=C2=A0 during boot and after that kernel=
 Hangs on powerpc with KASan changes.
below is stack=C2=A0BUG: KASan: unknown crash in printk+0x60/0xb0 at addr 4=
0bd4004Read of size 4 by task swapper/0CPU: 0 PID: 0 Comm: swapper Not tain=
ted 4.1.35-rt41-g8ca68bd-dirty #0Call Trace:[40bd7e70] [40967e08] dump_stac=
k+0x90/0xbc (unreliable)[40bd7ea0] [4014b588] kasan_report_error+0x408/0x41=
0[40bd7f00] [4014ba54] kasan_report+0x34/0x50[40bd7f30] [40149df4] __asan_l=
oad4+0xe4/0x100[40bd7f60] [40966e74] printk+0x60/0xb0[40bd7fb0] [40b418b4] =
start_kernel+0x9c/0x42c[40bd7ff0] [400003d8] set_ivor+0x140/0x17c
Memory state around the buggy address:=C2=A040bd3ec0: 00 00 00 0a 7f b0 67 =
70 7f f6 72 87 7f f6 d9 e5=C2=A040bd3f40: 00 00 00 0a 7f b0 67 70 7f f6 72 =
87 7f f6 d9 e5>40bd3fc0: 00 00 00 0a 7f b0 67 70 7f f6 72 87 7f f6 d9 e5=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^=C2=A040bd4040: 00 00 00 0=
a 7f b0 67 70 7f f6 72 87 7f f6 d9 e5=C2=A040bd40c0: 00 00 00 0a 7f b0 67 7=
0 7f f6 72 87 7f f6 d9 e5
please suggest some solutions which I can try. I am completely exhausted no=
w with trial and error.
I was not able to send mail through community and hence sending personal ma=
il.

THANKS AND REGARDS,
KHUSHAL K. GUMGAONKARM.TECH IN VISUAL INFORMATION AND EMBEDDED SYSTEM,IIT K=
HARAGPUR
------=_Part_5821058_1968557856.1507639866582
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:times new roman, new york, times, serif;font-size:13px"><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_2437"><span></span></div><div></div><di=
v id=3D"yui_3_16_0_ym19_1_1507639716641_4139">&nbsp;Hi Aneesh,</div><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_4211"><br id=3D"yui_3_16_0_ym19_1_15076=
39716641_4212"></div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4213">I am =
facing unknown error in printk&nbsp; during boot and after that kernel Hang=
s on powerpc with KASan changes.</div><div id=3D"yui_3_16_0_ym19_1_15076397=
16641_4214"><br id=3D"yui_3_16_0_ym19_1_1507639716641_4215"></div><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_4216">below is stack&nbsp;</div><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_4217">BUG: KASan: unknown crash in prin=
tk+0x60/0xb0 at addr 40bd4004</div><div id=3D"yui_3_16_0_ym19_1_15076397166=
41_4218">Read of size 4 by task swapper/0</div><div id=3D"yui_3_16_0_ym19_1=
_1507639716641_4219">CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.35-rt41-g8=
ca68bd-dirty #0</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4220">Call =
Trace:</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4221">[40bd7e70] [40=
967e08] dump_stack+0x90/0xbc (unreliable)</div><div id=3D"yui_3_16_0_ym19_1=
_1507639716641_4222">[40bd7ea0] [4014b588] kasan_report_error+0x408/0x410</=
div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4223">[40bd7f00] [4014ba54] =
kasan_report+0x34/0x50</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4224=
">[40bd7f30] [40149df4] __asan_load4+0xe4/0x100</div><div id=3D"yui_3_16_0_=
ym19_1_1507639716641_4225">[40bd7f60] [40966e74] printk+0x60/0xb0</div><div=
 id=3D"yui_3_16_0_ym19_1_1507639716641_4226">[40bd7fb0] [40b418b4] start_ke=
rnel+0x9c/0x42c</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4227">[40bd=
7ff0] [400003d8] set_ivor+0x140/0x17c</div><div id=3D"yui_3_16_0_ym19_1_150=
7639716641_4228"><br id=3D"yui_3_16_0_ym19_1_1507639716641_4229"></div><div=
 id=3D"yui_3_16_0_ym19_1_1507639716641_4230">Memory state around the buggy =
address:</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4231">&nbsp;40bd3e=
c0: 00 00 00 0a 7f b0 67 70 7f f6 72 87 7f f6 d9 e5</div><div id=3D"yui_3_1=
6_0_ym19_1_1507639716641_4232">&nbsp;40bd3f40: 00 00 00 0a 7f b0 67 70 7f f=
6 72 87 7f f6 d9 e5</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4233">&=
gt;40bd3fc0: 00 00 00 0a 7f b0 67 70 7f f6 72 87 7f f6 d9 e5</div><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_4234">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;^</div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4235">&n=
bsp;40bd4040: 00 00 00 0a 7f b0 67 70 7f f6 72 87 7f f6 d9 e5</div><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_4236">&nbsp;40bd40c0: 00 00 00 0a 7f b0=
 67 70 7f f6 72 87 7f f6 d9 e5</div><div id=3D"yui_3_16_0_ym19_1_1507639716=
641_4237"><br id=3D"yui_3_16_0_ym19_1_1507639716641_4238"></div><div id=3D"=
yui_3_16_0_ym19_1_1507639716641_4239">please suggest some solutions which I=
 can try. I am completely exhausted now with trial and error.</div><div id=
=3D"yui_3_16_0_ym19_1_1507639716641_4240"><br id=3D"yui_3_16_0_ym19_1_15076=
39716641_4241"></div><div id=3D"yui_3_16_0_ym19_1_1507639716641_4242" dir=
=3D"ltr"><font color=3D"#0000ff" face=3D"garamond, new york, times, serif" =
id=3D"yui_3_16_0_ym19_1_1507639716641_5801"><span style=3D"font-size: 16px;=
" id=3D"yui_3_16_0_ym19_1_1507639716641_5800"><b id=3D"yui_3_16_0_ym19_1_15=
07639716641_5799">I was not able to send mail through community and hence s=
ending personal mail.</b></span></font></div><div id=3D"yui_3_16_0_ym19_1_1=
507639716641_4242"><br></div><div id=3D"yui_3_16_0_ym19_1_1507639716641_424=
2"><br></div><div class=3D"signature" id=3D"yui_3_16_0_ym19_1_1507639716641=
_5785"><div id=3D"yui_3_16_0_ym19_1_1507639716641_5784"><span style=3D"font=
-size:16px;font-family:garamond, 'new york', times, serif;font-weight:bold;=
color:rgb(0, 0, 255);" id=3D"yui_3_16_0_ym19_1_1507639716641_5783">THANKS A=
ND REGARDS,</span></div><div id=3D"yui_3_16_0_ym19_1_1507639716641_7409"><s=
pan style=3D"font-size:medium;font-family:garamond, 'new york', times, seri=
f;font-weight:bold;color:rgb(0, 0, 255);"><br></span></div><div style=3D"ba=
ckground-color:transparent;font-style:normal;"><span style=3D"font-size:med=
ium;font-family:garamond, 'new york', times, serif;font-weight:bold;color:r=
gb(0, 0, 255);">KHUSHAL K. GUMGAONKAR</span></div><div style=3D"background-=
color:transparent;font-style:normal;"><span style=3D"font-size:medium;font-=
family:garamond, 'new york', times, serif;font-weight:bold;color:rgb(0, 0, =
255);">M.TECH IN VISUAL INFORMATION AND EMBEDDED SYSTEM,</span></div><div s=
tyle=3D"background-color:transparent;font-style:normal;"><span style=3D"fon=
t-size:16px;font-family:garamond, 'new york', times, serif;font-weight:bold=
;color:rgb(0, 0, 255);">IIT KHARAGPUR</span></div></div></div></body></html=
>
------=_Part_5821058_1968557856.1507639866582--
