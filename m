Return-Path: <andrew.l.bomber@maxtek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 9F9DF68A23
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 13:17:50 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k0C2HntT008475
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 18:17:49 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k0C2Hndp023289
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 18:17:49 -0800 (PST)
From: andrew.l.bomber@maxtek.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6171E.61F5BECC"
Date: Wed, 11 Jan 2006 18:17:48 -0800
Message-ID: <7E11C792A1D81242B9BFFC8355D4979387F6F9@us-bv-m23.global.tektronix.net>
To: <linuxppc-dev@ozlabs.org>
Cc: mullenp@pdx.edu
Subject: Linux 2.4.21 Embedded PPC 405 on Xilinx Virtex II pro is glacially
	slow
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6171E.61F5BECC
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C6171E.61F5BECC"


------_=_NextPart_002_01C6171E.61F5BECC
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,

I am running 2.4.21 on an embedded PPC 405 system, 125 MHz clock, 32 MB
SDRAM. It currently only has a UART and ttys00 is its console. It is
running the busy box monolithic binaries.  It is so slow that I have to
be cautious not to overrun the 16 byte UART 16550 input buffer. Has
anyone run into this problem before? Any ideas what might cause this or
how to troubleshoot it. I am kind of new to Linux and PPC.
 <<hypertermCaptureBBprompt.txt>>=20
Thanks,

Andrew


------_=_NextPart_002_01C6171E.61F5BECC
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Linux 2.4.21 Embedded PPC 405 on Xilinx Virtex II pro is =
glacially slow</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">Hello,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">I am running 2.4.21 on an embedded PPC 405 system, 125 =
MHz clock, 32 MB SDRAM. It currently only has a UART and ttys00 is its =
console. It is running the busy box monolithic binaries.&nbsp; It is so =
slow that I have to be cautious not to overrun the 16 byte UART 16550 =
input buffer. Has anyone run into this problem before? Any ideas what =
might cause this or how to troubleshoot it. I am kind of new to Linux =
and PPC.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;hypertermCaptureBBprompt.txt&gt;&gt; </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">Thanks,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">Andrew</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C6171E.61F5BECC--

------_=_NextPart_001_01C6171E.61F5BECC
Content-Type: text/plain;
	name="hypertermCaptureBBprompt.txt"
Content-Transfer-Encoding: base64
Content-Description: hypertermCaptureBBprompt.txt
Content-Disposition: attachment;
	filename="hypertermCaptureBBprompt.txt"

DQpsb2FkZWQgYXQ6ICAgICAwMDQwMDAwMCAwMDVFQTFFNCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgDQpib2FyZCBkYXRhIGF0OiAwMDVFNzEzQyAwMDVFNzE1NCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQpyZWxvY2F0ZWQgdG86ICAwMDQwNTYyNCAwMDQwNTYzQyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQp6aW1hZ2UgYXQ6ICAgICAwMDQwNUI0NCAwMDQ1
Njc1NSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQppbml0cmQgYXQ6ICAgICAwMDQ1
NzAwMCAwMDVFNjhFMyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQphdmFpbCByYW06
ICAgICAwMDVFQjAwMCAwMjAwMDAwMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQoN
CkxpbnV4L1BQQyBsb2FkOiBjb25zb2xlPXR0eVMwLDExNTIwMCByb290PS9kZXYvcmFtMCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KVW5jb21wcmVz
c2luZyBMaW51eC4uLmRvbmUuICAgICAgICAgICAgICAgICAgICAgICAgICAgDQpOb3cgYm9vdGlu
ZyB0aGUga2VybmVsICAgICAgICAgICAgICAgICAgICAgIA0KaWQgbWFjaCgpOiBkb25lICAgICAg
ICAgICAgICAgDQpNTVU6ZW50ZXIgICAgICAgICANCk1NVTpodyBpbml0ICAgICAgICAgICANCk1N
VTptYXBpbiAgICAgICAgIA0KTU1VOm1hcGluX3JhbSBkb25lICAgICAgICAgICAgICAgICAgDQpN
TVU6c2V0aW8gICAgICAgICANCk1NVTpleGl0ICAgICAgICANCkxpbnV4IHZlcnNpb24gMi40LjI2
IChwbUBtYXJzKSAoZ2NjIHZlcnNpb24gMy4zLjMgKERFTlggRUxESyAzLjEuMSAzLjMuMy05KSkg
IzkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQpTdW4gSmFuIDggMTY6NDI6MzUgUFNUIDIwMDYgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCnNldHVwX2FyY2g6IGVudGVyICAgICAgICAgICAgICAg
ICANCnNldHVwX2FyY2g6IGJvb3RtZW0gICAgICAgICAgICAgICAgICAgDQpYaWxpbnggVmlydGV4
LUlJIFBybyBwb3J0IChDKSAyMDAyIE1vbnRhVmlzdGEgU29mdHdhcmUsIEluYy4gKHNvdXJjZUBt
dmlzdGEuY29tKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQoNCmFyY2g6IGV4aXQgICAgICAgICAg
DQpPbiBub2RlIDAgdG90YWxwYWdlczogODE5MiAgICAgICAgICAgICAgICAgICAgICAgICAgDQp6
b25lKDApOiA4MTkyIHBhZ2VzLiAgICAgICAgICAgICAgICAgICAgDQp6b25lKDEpOiAwIHBhZ2Vz
LiAgICAgICAgICAgICAgICAgDQp6b25lKDIpOiAwIHBhZ2VzLiAgICAgICAgICAgICAgICAgDQpL
ZXJuZWwgY29tbWFuZCBsaW5lOiBjb25zb2xlPXR0eVMwLDExNTIwMCByb290PS9kZXYvcmFtMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQpY
aWxpbnggSU5UQyAjMCBhdCAweDgxMDEwMDAwIG1hcHBlZCB0byAweEZERkZFMDAwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KQ2FsaWJyYXRpbmcgZGVs
YXkgbG9vcC4uLiAzOTkuNzYgQm9nb01JUFMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KTWVtb3J5OiAyOTk0OGsgYXZhaWxhYmxlICg1OTZrIGtlcm5lbCBjb2RlLCAx
OTZrIGRhdGEsIDM2ayBpbml0LCAwayBoaWdobWVtKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCkRlbnRy
eSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAzLCAzMjc2OCBieXRlcykg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQpJbm9kZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAyLCAxNjM4
NCBieXRlcykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCk1vdW50IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlcjog
MCwgNDA5NiBieXRlcykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgDQpCdWZmZXIgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChv
cmRlcjogMCwgNDA5NiBieXRlcykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANClBhZ2UtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA4
MTkyIChvcmRlcjogMywgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KUE9TSVggY29uZm9ybWFuY2UgdGVzdGluZyBieSBVTklGSVggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KDQpMaW51eCBORVQ0LjAgZm9yIExpbnV4IDIuNA0KQmFzZWQg
dXBvbiBTd2Fuc2VhIFVuaXZlcnNpdHkgQ29tcHV0ZXIgU29jaWV0eSBORVQzLjAzOQ0KU3RhcnRp
bmcga3N3YXBkDQpTZXJpYWwgZHJpdmVyIHZlcnNpb24gNS4wNWMgKDIwMDEtMDctMDgpIHdpdGgg
bm8gc2VyaWFsIG9wdGlvbnMgZW5hYmxlZA0KdHR5UzAwIGF0IDB4ZmRmZmYwMDMgKGlycSA9IDMx
KSBpcyBhIDE2NTUwQQ0KUkFNRElTSyBkcml2ZXIgaW5pdGlhbGl6ZWQ6IDE2IFJBTSBkaXNrcyBv
ZiA0MDk2SyBzaXplIDEwMjQgYmxvY2tzaXplDQpsb29wOiBsb2FkZWQgKG1heCA4IGRldmljZXMp
DQpSQU1ESVNLOiBDb21wcmVzc2VkIGltYWdlIGZvdW5kIGF0IGJsb2NrIDANCkZyZWVpbmcgaW5p
dHJkIG1lbW9yeTogMTU5OGsgZnJlZWQNClZGUzogTW91bnRlZCByb290IChleHQyIGZpbGVzeXN0
ZW0pIHJlYWRvbmx5Lg0KRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMzZrIGluaXQNCg0K
DQpCdXN5Qm94IHYwLjYwLjUgKDIwMDUuMDMuMDctMTA6MDMrMDAwMCkgQnVpbHQtaW4gc2hlbGwg
KG1zaCkNCkVudGVyICdoZWxwJyBmb3IgYSBsaXN0IG9mIGJ1aWx0LWluIGNvbW1hbmRzLg0KDQoj
IGtpbGxhbGwgeGluZXRkDQojIGxzDQpiaW4gICBkZXYgICBldGMgICBmdHAgICBob21lICBsaWIg
ICBwcm9jICBzYmluICB0bXAgICB1c3IgICB2YXINCiMgdHR5UzogMSBpbnB1dCBvdmVycnVuKHMp
DQp3Y2gNCiMgZWNobyAiaGVsbG8gd29ycmxkIg0KaGVsbG8gd29ycmxkDQojcHMNCiAgUElEIFRU
WSAgICAgVWlkICAgICAgICBTaXplIFN0YXRlIENvbW1hbmQNCiAgICAxICAgICAgICAgcm9vdCAg
ICAgICAxODMyICAgUyAgIGluaXQgICAgICAgDQogICAgMiAgICAgICAgIHJvb3QgICAgICAgICAg
MCAgIFMgICBba2V2ZW50ZF0NCiAgICAzICAgICAgICAgcm9vdCAgICAgICAgICAwICAgUyAgIFtr
c29mdGlycWRfQ1BVMF0NCiAgICA0ICAgICAgICAgcm9vdCAgICAgICAgICAwICAgUyAgIFtrc3dh
cGRdDQogICAgNSAgICAgICAgIHJvb3QgICAgICAgICAgMCAgIFMgICBbYmRmbHVzaF0NCiAgICA2
ICAgICAgICAgcm9vdCAgICAgICAgICAwICAgUyAgIFtrdXBkYXRlZF0NCiAgIDE1IHR0eVMwICAg
cm9vdCAgICAgICAxODgwICAgUyAgIC1zaCANCiAgIDE5IHR0eVMwICAgcm9vdCAgICAgICAxOTQw
ICAgUiAgIHBzIA0KIyB0b3AgLWIgLW4gMQ0KdG9wOiBub3QgZm91bmQ=

------_=_NextPart_001_01C6171E.61F5BECC--
