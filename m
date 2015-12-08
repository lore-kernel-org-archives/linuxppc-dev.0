Return-Path: <wen.pu@powercore.com.cn>
Received: from smtpbg64.qq.com (smtpbg64.qq.com [103.7.28.238])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 986071A0F00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 18:37:25 +1100 (AEDT)
Received: from DZ-PC-031 (unknown [221.224.30.42])
 by esmtp4.qq.com (ESMTP) with SMTP id 0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Dec 2015 15:30:06 +0800 (CST)
Date: Tue, 8 Dec 2015 15:30:13 +0800
From: "wen.pu@powercore.com.cn" <wen.pu@powercore.com.cn>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/opal: add warning for unimplemented OPAL message type
Mime-Version: 1.0
Message-ID: <20151208153012239673106@powercore.com.cn>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart862661157014_=----"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_001_NextPart862661157014_=----
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64

SSBmb3VuZCB0aGF0IHRoZXJlIGFyZSB1bmltcGxlbWVudGVkIE9QQUwgbWVzc2FnZSB0eXBlcyAi
T1BBTF9NU0dfRVBPVyIgYW5kIA0KIk9QQUxfTVNHX0RQTyIgaW4gUG93ZXJOViBQbGF0Zm9ybS4g
SWYgc2tpYm9vdCBzZW5kIHN1Y2ggbWVzc2FnZXMgdG8ga2VybmVsLCANCm5vdGhpbmcgd2lsbCBo
YXBwZW4obm90aWZpZXJfY2FsbF9jaGFpbigpIHdpbGwgc2lsZW50bHkgZHJvcCBpdCkuIFNvIEkg
YWRkIGEgd2FybmluZyANCnRvIGluZm9ybSB3aGF0IGhhcyBoYXBwZW5lZCwgaXMgaXQgbmVjZXNz
YXJ5PyANCg0KU2lnbmVkLW9mZi1ieTogV2VuIFB1IDx3ZW4ucHVAcG93ZXJjb3JlLmNvbS5jbj4N
Ci0tLQ0KZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vcGFsLmMg
Yi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC5jDQppbmRleCBmMDg0YWZhLi5l
ZjQ5OGFiIDEwMDY0NA0KLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29wYWwu
Yw0KKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29wYWwuYw0KQEAgLTI4MSw2
ICsyODEsMTAgQEAgc3RhdGljIHZvaWQgb3BhbF9oYW5kbGVfbWVzc2FnZSh2b2lkKQ0KICBwcl93
YXJuaW5nKCIlczogVW5rbm93biBtZXNzYWdlIHR5cGU6ICV1XG4iLCBfX2Z1bmNfXywgdHlwZSk7
DQogIHJldHVybjsNCiAgfQ0KKyBpZih0eXBlID09IE9QQUxfTVNHX0VQT1cgfHwgdHlwZSA9PSBP
UEFMX01TR19EUE8pIHsNCisgcHJfd2FybmluZygiJXM6IFVuaW1wbGVtZW50ZWQgbWVzc2FnZSB0
eXBlOiAldVxuIiwgX19mdW5jX18sIHR5cGUpOw0KKyByZXR1cm47DQorIH0NCiAgb3BhbF9tZXNz
YWdlX2RvX25vdGlmeSh0eXBlLCAodm9pZCAqKSZtc2cpOw0KIH0NCi0tLQ0KDQpUaGFua3MhDQpX
ZW4gUHUNCg==

------=_001_NextPart862661157014_=----
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DGB2312"><style>body { line-height: 1.5; }body { font-size: 10.5pt; fon=
t-family: =CE=A2=C8=ED=D1=C5=BA=DA; color: rgb(0, 0, 0); line-height: 1.5;=
 }</style></head><body>=0A<div><span></span>I found that there are unimple=
mented&nbsp;<span style=3D"font-size: 10.5pt; line-height: 1.5; background=
-color: window;">OPAL&nbsp;message&nbsp;types "</span><span style=3D"font-=
size: 10.5pt; line-height: 1.5; background-color: window;">OPAL_MSG_EPOW</=
span><span style=3D"background-color: window; font-size: 10.5pt; line-heig=
ht: 1.5;">" and&nbsp;</span></div><div><span style=3D"background-color: wi=
ndow; font-size: 10.5pt; line-height: 1.5;">"</span><span style=3D"font-si=
ze: 10.5pt; line-height: 1.5; background-color: window;">OPAL_MSG_DPO</spa=
n><span style=3D"background-color: window; font-size: 10.5pt; line-height:=
 1.5;">"&nbsp;</span><span style=3D"font-size: 10.5pt; line-height: 1.5; b=
ackground-color: window;">in PowerNV Platform.&nbsp;</span><span style=3D"=
font-size: 10.5pt; line-height: 1.5; background-color: window;">If skiboot=
 send such messages to kernel,&nbsp;</span></div><div><span style=3D"font-=
size: 10.5pt; line-height: 1.5; background-color: window;">nothing will ha=
ppen(</span><span style=3D"font-size: 10.5pt; line-height: 1.5; background=
-color: window;">notifier_call_chain() will silently drop it</span><span s=
tyle=3D"font-size: 10.5pt; line-height: 1.5; background-color: window;">).=
 So I add a warning&nbsp;</span></div><div><span style=3D"background-color=
: window; font-size: 10.5pt; line-height: 1.5;">to inform&nbsp;</span><spa=
n style=3D"background-color: window; font-size: 10.5pt; line-height: 1.5;"=
>what has happened, is it necessary?&nbsp;</span></div><div><br></div><div=
>Signed-off-by: Wen Pu &lt;<span style=3D"color: rgb(0, 0, 238); text-deco=
ration: underline;">wen.pu@powercore.com.cn</span>&gt;</div><div>---</div>=
<div>diff&nbsp;--git&nbsp;a/arch/powerpc/platforms/powernv/opal.c&nbsp;b/a=
rch/powerpc/platforms/powernv/opal.c<br>index&nbsp;f084afa..ef498ab&nbsp;1=
00644<br>---&nbsp;a/arch/powerpc/platforms/powernv/opal.c<br>+++&nbsp;b/ar=
ch/powerpc/platforms/powernv/opal.c<br>@@&nbsp;-281,6&nbsp;+281,10&nbsp;@@=
&nbsp;static&nbsp;void&nbsp;opal_handle_message(void)<br>&nbsp;<span style=
=3D"white-space: pre;">	</span><span style=3D"white-space: pre;">	</span>p=
r_warning("%s:&nbsp;Unknown&nbsp;message&nbsp;type:&nbsp;%u\n",&nbsp;__fun=
c__,&nbsp;type);<br>&nbsp;<span style=3D"white-space: pre;">	</span><span =
style=3D"white-space: pre;">	</span>return;<br>&nbsp;<span style=3D"white-=
space: pre;">	</span>}<br>+<span style=3D"white-space: pre;">	</span>if(ty=
pe&nbsp;=3D=3D&nbsp;OPAL_MSG_EPOW&nbsp;||&nbsp;type&nbsp;=3D=3D&nbsp;OPAL_=
MSG_DPO)&nbsp;{<br>+<span style=3D"white-space: pre;">	</span><span style=
=3D"white-space: pre;">	</span>pr_warning("%s:&nbsp;Unimplemented&nbsp;mes=
sage&nbsp;type:&nbsp;%u\n",&nbsp;__func__,&nbsp;type);<br>+<span style=3D"=
white-space: pre;">	</span><span style=3D"white-space: pre;">	</span>retur=
n;<br>+<span style=3D"white-space: pre;">	</span>}<br>&nbsp;<span style=3D=
"white-space: pre;">	</span>opal_message_do_notify(type,&nbsp;(void&nbsp;*=
)&amp;msg);<br>&nbsp;}</div><div>---<br></div>=0A<div><br></div><div>Thank=
s!</div><div>Wen Pu</div>=0A</body></html>
------=_001_NextPart862661157014_=------
