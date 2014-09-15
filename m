Return-Path: <Jay_Chen@alphanetworks.com>
Received: from mse.alphanetworks.com (unknown [124.219.30.61])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C2571A0121
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 18:28:44 +1000 (EST)
Received: from mse.alphanetworks.com (localhost [127.0.0.2] (may be forged))
 by mse.alphanetworks.com with ESMTP id s8F8FbKr079666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:15:37 +0800 (GMT-8)
 (envelope-from Jay_Chen@alphanetworks.com)
Received: from HQCAS02.alphanetworks.com ([172.19.3.67])
 by mse.alphanetworks.com with ESMTP id s8F8FVlw079632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:15:31 +0800 (GMT-8)
 (envelope-from Jay_Chen@alphanetworks.com)
From: <Jay_Chen@alphanetworks.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Data Cache Push Parity Error
Date: Mon, 15 Sep 2014 08:15:32 +0000
Message-ID: <5538ce4d2de54f2fb7a29a66b33d70b0@HQMBS02.alphanetworks.com>
Content-Type: multipart/alternative;
 boundary="_000_5538ce4d2de54f2fb7a29a66b33d70b0HQMBS02alphanetworkscom_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_5538ce4d2de54f2fb7a29a66b33d70b0HQMBS02alphanetworkscom_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGFtIHVzaW5nIFAyMDIwIHdpdGggTGludXgga2VybmVsIDMuOC4xMy4NClNv
bWV0aW1lcyBteSBzeXN0ZW0gZW5jb3VudGVycyBtYWNoaW5lIGNoZWNrIGV4Y2VwdGlvbiBhbmQg
aXQgc2hvd3MgoadDYXVzZWQgYnkgKGZyb20gTUNTUj0yMDAwMDAwMCk6IERhdGEgQ2FjaGUgUHVz
aCBQYXJpdHkgRXJyb3KhqC4NCkNvdWxkIGFueW9uZSBzaG93IG1lIHNvbWUgaGludHMgdG8gZGln
IGludG8gdGhpcyBpc3N1ZT8gQW55IGNvbW1lbnQgaXMgd2VsY29tZS4NClRoYW5rcyBpbiBhZHZh
bmNlLg0KDQogICAgICAgICAgICAgICAgSmF5IENoZW6hSw0KDQoNClRoaXMgZWxlY3Ryb25pYyBt
YWlsIHRyYW5zbWlzc2lvbiBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgbmFtZWQgcmVjaXBpZW50
LiBJdCBjb250YWlucyBpbmZvcm1hdGlvbiB3aGljaCBtYXkgYmUgcHJpdmlsZWdlZCxjb25maWRl
bnRpYWwgYW5kIGV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXcuIERp
c3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiwgb3IgY29weWluZyBvZiB0aGlzIGNvbW11bmljYXRp
b24gYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIHJlY2lwaWVudCBvciB0aGUgcmVjaXBpZW50J3Mg
YWdlbnQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgdGhpcyBlbGVjdHJvbmljIG1haWwgdHJh
bnNtaXNzaW9uIGlzIHJlY2VpdmVkIGluIGVycm9yLCBQbGVhc2Ugbm90aWZ5IHVzIGltbWVkaWF0
ZWx5IGFuZCBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGFsbCBhdHRhY2htZW50cyBvZiBpdCBmcm9t
IHlvdXIgY29tcHV0ZXIgc3lzdGVtLiBUaGFuayB5b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQo=

--_000_5538ce4d2de54f2fb7a29a66b33d70b0HQMBS02alphanetworkscom_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=B7s=B2=D3=A9=FA=C5=E9;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B7s=B2=D3=A9=FA=C5=E9";
	panose-1:2 2 5 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-TW" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">Hi all,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">I am using P=
2020 with Linux kernel 3.8.13.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">Sometimes my=
 system encounters machine check exception and it shows =A1=A7Caused by (fr=
om MCSR=3D20000000): Data Cache Push Parity Error=A1=A8.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">Could anyone=
 show me some hints to dig into this issue? Any comment is welcome.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">Thanks in ad=
vance.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;Jay Chen=A1K<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
<h3></h3>
<p>This electronic mail transmission is intended only for the named recipie=
nt. It contains information which may be privileged,confidential and exempt=
 from disclosure under applicable law. Dissemination, distribution, or copy=
ing of this communication by anyone
 other than the recipient or the recipient's agent is strictly prohibited. =
If this electronic mail transmission is received in error, Please notify us=
 immediately and delete the message and all attachments of it from your com=
puter system. Thank you for your
 cooperation. </p>
<p></p>
</body>
</html>

--_000_5538ce4d2de54f2fb7a29a66b33d70b0HQMBS02alphanetworkscom_--
