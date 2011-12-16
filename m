Return-Path: <liguohu@live.com>
Received: from blu0-omc4-s28.blu0.hotmail.com (blu0-omc4-s28.blu0.hotmail.com
 [65.55.111.167]) by ozlabs.org (Postfix) with ESMTP id BC4E01007D5
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2011 11:45:35 +1100 (EST)
Message-ID: <BLU0-SMTP14243F8B3BC45B200DD0EF8C6A00@phx.gbl>
Date: Fri, 16 Dec 2011 08:38:58 +0800
From: G.H.Lee <liguohu@live.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Help needed with porting ether-net driver from ADS5121 to TWR-MPC5125
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart524012252505_=----"
Reply-To: liguohu <liguohu@live.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_001_NextPart524012252505_=----
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8sIGFsbA0KDQpJIGFtIGEgbmV3IHVzZXIgb2YgdGhlIGJvYXJkIFRXUi1NUEM1MTI1IG1h
ZGUgYnkgZnJlZXNjYWxlLiBOb3cgSSBhbSB0cnlpbmcgdG8gcG9ydGluZyB0aGUgbmV3IGtlcm5l
bCwgaS5lLiB0aGUgdmVyc2lvbiAzLjAuNCwgdG8gdGhpcyBib2FyZC4gSSBoYXZlIHBvcnRpbmcg
dGhlIHNlcmlhbCBkcml2ZXIgYW5kIHRoZSBuYW5kIGZsYXNoIGRyaXZlciBzdWNjZXNzZnVsbHku
IEFuZCBJIGNhbiBhbHNvIG1vdW50IHRoZSByb290IGZpbGUgc3lzdGVtLiBCdXQgSSBjYW4gbm90
IHVzZSB0aGUgZXRoZXItbmV0IGludGVyZmFjZSBub3cuIEkgaGF2ZSB0cmllZCB0byBwb3J0IHRo
ZSBldGhlci1uZXQgZHJpdmVyIGJhc2VkIG9uIHRoZSBldGhlci1uZXQgZHJpdmVyIGZvciBBRFMg
NTEyMSwgd2hpY2ggaXMgcHJvdmlkZWQgYnkgdGhlIG5ldyBrZXJuZWwgMy4wLjQuIFRoZSBvbmx5
IHRoaW5nIEkgaGF2ZSB0byBkbyBpbiB0aGUgcG9ydGluZyBpcyB0aGF0IEkgc2hvdWxkIGNoYW5n
ZSB0aGUgTUlJIG1vZGUgaW4gQURTNTEyMSBib2FyZCB0byBSTUlJIG1vZGUgaW4gbXkgYm9hcmQu
IEFuZCBJIGZpbmQgdGhhdCBJIGNhbiBzZW5kIHBhY2thZ2VzIG91dCBpZiBJIHVzZSB0aGUgInBp
bmciIGNvbW1hbmQuIEJ1dCBJIGNhbiBub3QgcmVjZWl2ZSBhbnkgcGFja2FnZSBmb3IgcmVzcG9u
ZGluZy4gQW5kIEkgYWxzbyBmb3VuZCB0aGF0IHRoZSBpbnRlcnJ1cHQgcm91dGluZSBmb3Igc2Vu
ZGluZyBwYWNrYWdlcyB3YXMgcnVubmluZyBidXQgdGhlIGludGVycnVwdCByb3V0aW5lIGZvciBy
ZWNlaXZpbmcgbWVzc2FnZSB3YXMgbm90IGNhbGxlZCBieSB0aGUga2VybmVsLiBJIGRvbid0IGtu
b3cgd2h5LiANCg0KQ2FuIGFueW9uZSBoZWxwIG1lPyBTaG91bGQgSSBjaGFuZ2Ugc29tZSBvdGhl
ciBjb2RlcyBiZXlvbmQgdGhlIGV0aGVyLW5ldCBkcml2ZXI/IFNvbWVvbmUgdG9sZCBtZSB0aGF0
IEkgc2hvdWxkIHJlZ3VsYXRlIHRoZSBrZXJuZWwgYmVjYXVzZSBvZiB0aGUgZGlmZmVyZW5jZXMg
YW1vbmcgdGhlIGRpZmZlcmVudCBrZXJlbmwgdmVyc2lvbnMgaWYgdGhlIE1BQyB3YXMgaW50ZWdy
YXRlZCBpbnNpZGUgdGhlIFNPQywgd2hpY2ggd2FzIHRoZSBmYXR0byBpbiBteSBib2FyZC4gQnV0
IEkgZG9uJ3Qga25vdyBob3cgdG8gcmVndWxhdGUuDQoNCkIuVC5XLiA6IFRoZSBoYXJkd2FyZSBp
cyBnb29kIGVub3VnaCBiZWNhdXNlIEkgY2FuIHVzZSB0aGUgZXRoZXIgbmV0IGludGVyZmFjZSBp
biB1LWJvb3QgYW5kIGlmIHVzaW5nIHRoZSBrZXJuZWwgcHJvdmlkZWQgYnkgZnJlZXNjYWxlLiBN
b3Jlb3ZlciwgdGhlIHUtYm9vdCBpcyBhbHNvIGdvb2QgYW5kIEkgaGF2ZSBub3QgY2hhbmdlIGl0
LiBTbyB0aGUgZXRoZXIgbmV0IHBpbnMgYXJlIGNvbmZpZ3VyZWQgY29ycmVjdGx5LiBCdXQgSSBo
YXZlIG5vdCBwb3J0aW5nIHRoZSBkcml2ZXIgZm9yIERNQS4gQnV0IEkgdGhpbmsgaXQgaXMgT2sg
YmVjYXVzZSB0aGUgInBpbmciIGNvbW1hbmQgY2FuIGJlIHVzZWQgY29ycmVjdGx5IGlmIHVzaW5n
IHRoZSBrZXJuZWwgcHJvdmlkZWQgYnkgZnJlZXNjYWxlIHdoZW4gSSBjYW5jZWwgdGhlIERNQSBk
cml2ZXIgd2hlbiBjb25maWd1cmluZyB0aGUga2VybmVsLg0KDQpUaGFua3MuDQoNCg0KDQoNCkd1
b2h1IExp

------=_001_NextPart524012252505_=----
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<STYLE>
BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
P {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
BODY {
	FONT-SIZE: 10.5pt; COLOR: #000000; LINE-HEIGHT: 1.5; FONT-FAMILY: =CB=CE=
=CC=E5
}
</STYLE>

<META content=3D"MSHTML 6.00.2900.6148" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 10px">
<DIV>
<DIV>
<DIV>Hello, all</DIV>
<DIV>
<DIV class=3DFoxDiv20111215105216561795>
<DIV>&nbsp;</DIV>
<DIV>
<DIV class=3Dxg_user_generated>
<P>I am a new user of the board TWR-MPC5125 made by freescale. Now I am tr=
ying=20
to porting the new kernel, i.e. the version 3.0.4, to this board. I have p=
orting=20
the serial driver and the nand flash driver successfully. And I can also m=
ount=20
the root file system. But I can not use the ether-net interface now. I hav=
e=20
tried to port the ether-net driver based on the ether-net driver for ADS 5=
121,=20
which&nbsp;is provided by the new kernel 3.0.4.&nbsp;The only&nbsp;thing I=
 have=20
to do in the porting is that I should change the MII mode in ADS5121 board=
 to=20
RMII mode in my board.&nbsp;And I find that I can send packages out if I u=
se the=20
"ping" command. But I can not receive any package for responding. And I al=
so=20
found that the interrupt routine for sending packages was running but the=20
interrupt routine for receiving message was not called by the kernel. I do=
n't=20
know why. </P>
<P>&nbsp;</P>
<P>Can anyone help me? Should I change some other codes beyond the ether-n=
et=20
driver? Someone told me that I should regulate the kernel because of the=20
differences among the different kerenl versions if the MAC was integrated =
inside=20
the SOC, which was the fatto in my board. But I don't know how to regulate=
.</P>
<P>&nbsp;</P>
<P></P>
<P>B.T.W. : The hardware is good enough because I can use the ether net=20
interface in u-boot and if using the kernel provided by freescale. Moreove=
r, the=20
u-boot is also good and I have not change it. So the ether net pins are=20
configured correctly. But I have not porting the driver for DMA. But I thi=
nk it=20
is Ok because the "ping" command can be used correctly if using the kernel=
=20
provided by freescale when I cancel the DMA driver when configuring the=20
kernel.</P>
<P>&nbsp;</P>
<P>Thanks.</P></DIV></DIV></DIV></DIV></DIV></DIV>
<DIV>&nbsp;</DIV>
<HR style=3D"WIDTH: 210px; HEIGHT: 1px" align=3Dleft color=3D#b5c4df SIZE=
=3D1>

<DIV><SPAN>
<DIV><SPAN style=3D"FONT-SIZE: 10.5pt; COLOR: #000000; FONT-FAMILY: =CB=CE=
=CC=E5">Guohu=20
Li</SPAN></DIV>
<DIV><SPAN style=3D"FONT-SIZE: 10.5pt; COLOR: #000000; FONT-FAMILY: =CB=CE=
=CC=E5"><SPAN=20
class=3Dshort_text lang=3Den c=3D"4" a=3D"undefined" closure_uid_cg7imv=3D=
"127"><SPAN=20
class=3Dhps closure_uid_cg7imv=3D"108">
<HR id=3Dnull>
</SPAN></SPAN></SPAN></DIV></SPAN></DIV></BODY></HTML>

------=_001_NextPart524012252505_=------
