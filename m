Return-Path: <Hengmeej@linsys.ca>
Received: from linsys.ca (205-200-74-130.static.mts.net [205.200.74.130])
	by ozlabs.org (Postfix) with ESMTP id 6C18767B9B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 02:46:30 +1100 (EST)
Received: from WorldClient by linsys.ca (MDaemon PRO v9.5.3)
	with ESMTP id md50000125170.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Dec 2006 09:35:34 -0600
Date: Wed, 06 Dec 2006 09:35:32 -0600
From: "Jantira Hengmeechai (Tai)" <Hengmeej@linsys.ca>
To: linuxppc-embedded@ozlabs.org
Subject: Root filesystem
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1206-0935-32-PART-BREAK"
Message-ID: <WorldClient-F200612060935.AA35320064@linsys.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--1206-0935-32-PART-BREAK
Content-Type: multipart/alternative; boundary="_1206-0935-32-PART-BREAK"

--_1206-0935-32-PART-BREAK
Content-Type: text/plain; charset=us-ascii

Hi all,

I am implementing uClinux using linuxppc-2.4 for the Xilinx Virtex-4 powerpc 
board.
http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/powerpc_linux/

After I downloaded and booted up, it just stopped after "Mounting var: " 
message.

These are the MTD options that I've enabled:

# Memory Technology Devices (MTD)
CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_RAM=y
CONFIG_MTD_UCLINUX=y

And I've enabled "/proc file system support", "ROM file system support", and 
"Second extended fs support"
for the File systems options.

Best Regards,
Jantira.

 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jantira Hengmeechai (Tai)
Embedded Software Developer
 
Linear Systems Ltd.
1717 Dublin Avenue, Unit 1
Winnipeg., MB., R3H 0H2, Canada 
Phone: 1 204 632 4300 ext.23, Fax: 1 204 697 2417

--_1206-0935-32-PART-BREAK
Content-Type: text/html; charset=us-ascii

<HTML>
<HEAD> <META http-equiv=Content-Type content="text/html; charset=us-ascii"> 
<STYLE title="table borders">.htmtableborders, .htmtableborders td, 
.htmtableborders th {border : 1px dashed lightgrey ! important;}  </STYLE>  
<STYLE type=text/css>html, body { border: 0px; }  span.macro, span.macro ul, 
span.macro div, span.macro p {background : #CCCCCC;} </STYLE>  <STYLE 
type=text/css> p{margin-bottom: 0.15em;margin-top: 
0.15em;}body{font-family:;font-size:10pt;}; </STYLE> </HEAD> <BODY> <STYLE 
title="table borders">.htmtableborders, .htmtableborders td,  
.htmtableborders th {border : 1px dashed lightgrey ! important;}  </STYLE>  
<STYLE type=text/css>html, body { border: 0px; }  span.macro, span.macro ul, 
 span.macro div, span.macro p {background : #CCCCCC;} </STYLE>  <STYLE 
type=text/css> p{margin-bottom: 0.15em;margin-top:  
0.15em;}body{font-family:;font-size:10pt;}; </STYLE> <FONT style="FONT-SIZE: 
10pt; FONT-FAMILY: "> <DIV>Hi all,</DIV> <DIV>&nbsp;</DIV> <DIV>I&nbsp;am 
implementing uClinux using linuxppc-2.4&nbsp;for the Xilinx Virtex-4 powerpc 
board.</DIV> <DIV><A 
href="http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/powerpc_linux/">
http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/powerpc_linux/</A></DIV> 
<DIV>&nbsp;</DIV> <DIV>After I&nbsp;downloaded and booted up,&nbsp;it just 
stopped&nbsp;after "Mounting var: "&nbsp;message.</DIV> <DIV>&nbsp;</DIV> 
<DIV>These are the MTD options that I've enabled:</DIV> <DIV>&nbsp;</DIV>
<FONT size=2> <DIV># Memory Technology Devices (MTD)</DIV> <DIV>
CONFIG_MTD=y</DIV> <DIV>CONFIG_MTD_PARTITIONS=y</DIV> <DIV>
CONFIG_MTD_CHAR=y</DIV> <DIV>CONFIG_MTD_BLOCK=y</DIV> <DIV>
CONFIG_MTD_CFI=y</DIV> <DIV>CONFIG_MTD_JEDECPROBE=y</DIV> <DIV>
CONFIG_MTD_GEN_PROBE=y</DIV> <DIV>CONFIG_MTD_CFI_AMDSTD=y</DIV> <DIV>
CONFIG_MTD_RAM=y</DIV> <DIV>CONFIG_MTD_UCLINUX=y</DIV> <DIV></FONT>
&nbsp;</DIV> <DIV>And I've enabled "/proc file system support", "ROM file 
system support", and "Second extended fs support"</DIV> <DIV>for the File 
systems options.</DIV> <DIV>&nbsp;</DIV> <DIV>Best Regards,</DIV> <DIV>
Jantira.</DIV> <DIV><BR>&nbsp;</DIV></FONT> <DIV>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</DIV> <DIV>Jantira Hengmeechai 
(Tai)</DIV> <DIV>Embedded Software Developer</DIV> <DIV>&nbsp;</DIV> <DIV>
Linear Systems Ltd.<BR>1717 Dublin Avenue, Unit 1</DIV> <DIV>Winnipeg., MB., 
R3H 0H2, Canada </DIV> <DIV>Phone: 1 204 632 4300 ext.23, Fax: 1 204 697 
2417</DIV></BODY>
</HTML>

--_1206-0935-32-PART-BREAK--

--1206-0935-32-PART-BREAK
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="CAPTURE.TXT"

Cg1sb2FkZWQgYXQ6ICAgICAwMDQwMDAwMCAwMDRGOTFFMAoNYm9hcmQgZGF0YSBhdDogMDA0RjYx
MzggMDA0RjYxNTAKDXJlbG9jYXRlZCB0bzogIDAwNDA1MzA0IDAwNDA1MzFDCg16aW1hZ2UgYXQ6
ICAgICAwMDQwNThDOSAwMDRGNTZCMwoNYXZhaWwgcmFtOiAgICAgMDA0RkEwMDAgMTAwMDAwMDAK
DQoNTGludXgvUFBDIGxvYWQ6IHJvb3Q9L2Rldi9tdGRibG9jazAgcm9vdGZzdHlwZT1yb21mcyBy
dyBpcD1vbgoNVW5jb21wcmVzc2luZyBMaW51eC4uLmRvbmUuCg1Ob3cgYm9vdGluZyB0aGUga2Vy
bmVsCg1MaW51eCB2ZXJzaW9uIDIuNC4zMC1wcmUxIChkZXZlbEBsb2NhbGhvc3QubG9jYWxkb21h
aW4pIChnY2MgdmVyc2lvbiAzLjQuMikgIzIxNCBUdWUgRGVjIDUgMTU6NTQ6NTUgRVNUIDIwMDYN
ClhpbGlueCBWaXJ0ZXgtSUkgUHJvIHBvcnQgKEMpIDIwMDIgTW9udGFWaXN0YSBTb2Z0d2FyZSwg
SW5jLiAoc291cmNlQG12aXN0YS5jb20pDQpPbiBub2RlIDAgdG90YWxwYWdlczogNjU1MzYNCnpv
bmUoMCk6IDY1NTM2IHBhZ2VzLg0Kem9uZSgxKTogMCBwYWdlcy4NCnpvbmUoMik6IDAgcGFnZXMu
DQpLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PS9kZXYvbXRkYmxvY2swIHJvb3Rmc3R5cGU9cm9t
ZnMgcncgaXA9b24NClhpbGlueCBJTlRDICMwIGF0IDB4NDEyMDAwMDAgbWFwcGVkIHRvIDB4RkRG
RkYwMDANCkNhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4gMjk5LjgyIEJvZ29NSVBTDQpNZW1vcnk6
IDI1Njc4OGsgYXZhaWxhYmxlICg1ODhrIGtlcm5lbCBjb2RlLCAxNjQ0ayBkYXRhLCAzNmsgaW5p
dCwgMGsgaGlnaG1lbSkNCkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChv
cmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQ0KSW5vZGUgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAx
NjM4NCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykNCk1vdW50IGNhY2hlIGhhc2ggdGFibGUgZW50
cmllczogNTEyIChvcmRlcjogMCwgNDA5NiBieXRlcykNCkJ1ZmZlciBjYWNoZSBoYXNoIHRhYmxl
IGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNCwgNjU1MzYgYnl0ZXMpDQpQYWdlLWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMpDQpQT1NJWCBjb25m
b3JtYW5jZSB0ZXN0aW5nIGJ5IFVOSUZJWA0KTGludXggTkVUNC4wIGZvciBMaW51eCAyLjQNCkJh
c2VkIHVwb24gU3dhbnNlYSBVbml2ZXJzaXR5IENvbXB1dGVyIFNvY2lldHkgTkVUMy4wMzkNClN0
YXJ0aW5nIGtzd2FwZA0KUkFNRElTSyBkcml2ZXIgaW5pdGlhbGl6ZWQ6IDE2IFJBTSBkaXNrcyBv
ZiA0MDk2SyBzaXplIDEwMjQgYmxvY2tzaXplDQp1Y2xpbnV4W210ZF06IFJBTSBwcm9iZSBhZGRy
ZXNzPTB4YzAwZDE2MjQgc2l6ZT0weDE2NjAwMA0KQ3JlYXRpbmcgMSBNVEQgcGFydGl0aW9ucyBv
biAiUkFNIjoNCjB4MDAwMDAwMDAtMHgwMDE2NjAwMCA6ICJST01mcyINCnVjbGludXhbbXRkXTog
c2V0IFJPTWZzIHRvIGJlIHJvb3QgZmlsZXN5c3RlbQ0KVkZTOiBNb3VudGVkIHJvb3QgKHJvbWZz
IGZpbGVzeXN0ZW0pIHJlYWRvbmx5Lg0KRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMzZr
IGluaXQNCk1vdW50b3VudGluZyBwcm9jOiANCk1vdW50aW5nIHZhcjogDQo=

--1206-0935-32-PART-BREAK--
