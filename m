Return-Path: <nareshgbhat@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 4BAF0DDF03
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 17:44:54 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so541057wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 00:44:52 -0700 (PDT)
Message-ID: <cf9b3c760807300044y4625ca2am60367defaa98d49b@mail.gmail.com>
Date: Wed, 30 Jul 2008 13:14:52 +0530
From: "Naresh Bhat" <nareshgbhat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Board is not booting - Please Help me
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_32902_30000386.1217403892762"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_32902_30000386.1217403892762
Content-Type: multipart/alternative;
	boundary="----=_Part_32903_8025281.1217403892762"

------=_Part_32903_8025281.1217403892762
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys
I have ML507 board.  By using "ml507_bsb_design_ppc440.zip"
I have created the "Base System Builder" project and also

I am able to create the following files sucessfully.

1. My own "DTS" file (attached with the mail)
2. My own "download.bit" file
3. My own ACE file. (Used the Montavista Pro 5.0 kernel., Kernel is compiled
with ARCH=powerpc, CROSS_COMPILE=ppc_440-, used the ml507_defconfig)

*My problem is:*
The ML507 board Booting and nothing will be displayed after device flat
tree(see the below Logs).

please help me on this what could be the problem?.

*LOGS:*
=======================================
* Welcome to the Xilinx Virtex-5 ML507 Evaluation Platform Bootloader Menu!

Please choose a demo by typing in the number of the demo you want to use

Or select a demo using the directional buttons (C,W,S,E,N)
  (Then press the center (C) button to start the selected demo)

1. Virtex-5 Slide Show
2. Web Server Demo
3. Simon Game
4. Board Diagnostics (XROM)
5. USB Demo
6. My own ACE file
7. Ring Tone Player
Rebooting to System ACE Configuration Address 6...
booting virtex
memstart=0x10
memsize=0xf

zImage starting: loaded at 0x00400000 (sp: 0x00851eb8)
Allocating 0x33770c bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x00580d73)...done 0x312590 bytes
Attached initrd image at 0x00581000-0x00850e21
initrd head: 0x1f8b0808

Linux/PowerPC load: console=ttyS0,9600 ip=off root=/dev/ram rw
Finalizing device tree... flat tree at 0x85e300*

======================================================================

-- 
Naresh Bhat

------=_Part_32903_8025281.1217403892762
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Guys<br clear="all">I have ML507 board.&nbsp; By using &quot;ml507_bsb_design_ppc440.zip&quot;<br>I have created the &quot;Base System Builder&quot; project and also<br><br>I am able to create the following files sucessfully.<br>

<br>1. My own &quot;DTS&quot; file (attached with the mail)<br>2. My own &quot;download.bit&quot; file<br>3.
My own ACE file. (Used the Montavista Pro 5.0 kernel., Kernel is
compiled with ARCH=powerpc, CROSS_COMPILE=ppc_440-, used the
ml507_defconfig)<br>
<br><b>My problem is:</b><br>The ML507 board Booting and nothing will
be displayed after device flat tree(see the below Logs). <br><br>please help me on this
what could be the problem?. <br><br><b>LOGS:</b><br><div dir="ltr">=======================================<br><b><span style="color: rgb(0, 0, 153);"> Welcome to the Xilinx Virtex-5 ML507 Evaluation Platform Bootloader Menu!</span><br style="color: rgb(0, 0, 153);">

<br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">Please choose a demo by typing in the number of the demo you want to use</span><br style="color: rgb(0, 0, 153);"><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">Or select a demo using the directional buttons (C,W,S,E,N)</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">&nbsp; (Then press the center (C) button to start the selected demo)</span><br style="color: rgb(0, 0, 153);">

<br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">1. Virtex-5 Slide Show</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">2. Web Server Demo</span><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">3. Simon Game</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">4. Board Diagnostics (XROM)</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">5. USB Demo</span><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">6. My own ACE file</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">7. Ring Tone Player</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">Rebooting to System ACE Configuration Address 6...</span><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">booting virtex</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">memstart=0x10</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">memsize=0xf</span><br style="color: rgb(0, 0, 153);">

<br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">zImage starting: loaded at 0x00400000 (sp: 0x00851eb8)</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">Allocating 0x33770c bytes for kernel ...</span><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">gunzipping (0x00000000 &lt;- 0x0040d000:0x00580d73)...done 0x312590 bytes</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">Attached initrd image at 0x00581000-0x00850e21</span><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">initrd head: 0x1f8b0808</span><br style="color: rgb(0, 0, 153);"><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">Linux/PowerPC load: console=ttyS0,9600 ip=off root=/dev/ram rw</span><br style="color: rgb(0, 0, 153);">

<span style="color: rgb(0, 0, 153);">Finalizing device tree... flat tree at 0x85e300</span></b><br><br>======================================================================</div><br>-- <br>Naresh Bhat<br><br>
</div>

------=_Part_32903_8025281.1217403892762--

------=_Part_32902_30000386.1217403892762
Content-Type: application/octet-stream; name=fdt.dts
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fj9n0rdm0
Content-Disposition: attachment; filename=fdt.dts

LyoNCiAqIChDKSBDb3B5cmlnaHQgMjAwNy0yMDA4IFhpbGlueCwgSW5jLg0KICogKEMpIENvcHly
aWdodCAyMDA3LTIwMDggTWljaGFsIFNpbWVrDQogKg0KICogTWljaGFsIFNJTUVLIDxtb25zdHJA
bW9uc3RyLmV1Pg0KICoNCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCiAqIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzDQogKiBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZg0KICogdGhlIExpY2Vu
c2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQogKg0KICogVGhpcyBw
cm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
DQogKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZg0KICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiBTZWUgdGhlDQogKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9y
ZSBkZXRhaWxzLg0KICoNCiAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQogKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsg
aWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQ0KICogRm91bmRhdGlvbiwgSW5jLiwg
NTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwNCiAqIE1BIDAyMTExLTEzMDcgVVNB
DQogKg0KICogQ0FVVElPTjogVGhpcyBmaWxlIGlzIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGJ5
IGxpYmdlbi4NCiAqIFZlcnNpb246IFhpbGlueCBFREsgMTAuMS4wMiBFREtfS19TUDIuNQ0KICov
DQoNCi8gew0KCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCSNzaXplLWNlbGxzID0gPDE+Ow0KCWNv
bXBhdGlibGUgPSAieGxueCx2aXJ0ZXgiOw0KCWRjci1wYXJlbnQgPSA8JnBwYzQ0MF8wPjsNCglt
b2RlbCA9ICJ0ZXN0aW5nIjsNCglERFIyX1NEUkFNOiBtZW1vcnlAMCB7DQoJCWRldmljZV90eXBl
ID0gIm1lbW9yeSI7DQoJCXJlZyA9IDwgMCAxMDAwMDAwMCA+Ow0KCX0gOw0KCWNob3NlbiB7DQoJ
CWJvb3RhcmdzID0gImNvbnNvbGU9dHR5UzAsOTYwMCByb290PS9kZXYvbmZzIHJ3IjsNCgl9IDsN
CgljcHVzIHsNCgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQoJCSNjcHVzID0gPDE+Ow0KCQkjc2l6
ZS1jZWxscyA9IDwwPjsNCgkJcHBjNDQwXzA6IGNwdUAwIHsNCgkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KCQkJI3NpemUtY2VsbHMgPSA8MT47DQoJCQljbG9jay1mcmVxdWVuY3kgPSAiIjsNCgkJ
CWNvbXBhdGlibGUgPSAiUG93ZXJQQyw0NDAiLCAiaWJtLHBwYzQ0MCI7DQoJCQlkLWNhY2hlLWxp
bmUtc2l6ZSA9IDwyMD47DQoJCQlkLWNhY2hlLXNpemUgPSA8ODAwMD47DQoJCQlkY3ItYWNjZXNz
LW1ldGhvZCA9ICJuYXRpdmUiOw0KCQkJZGNyLWNvbnRyb2xsZXIgOw0KCQkJZGV2aWNlX3R5cGUg
PSAiY3B1IjsNCgkJCWktY2FjaGUtbGluZS1zaXplID0gPDIwPjsNCgkJCWktY2FjaGUtc2l6ZSA9
IDw4MDAwPjsNCgkJCW1vZGVsID0gIlBvd2VyUEMsNDQwIjsNCgkJCXJlZyA9IDwwPjsNCgkJCXRp
bWViYXNlLWZyZXF1ZW5jeSA9ICIiOw0KCQkJeGxueCxhcHUtY29udHJvbCA9IDwyMDAwPjsNCgkJ
CXhsbngsYXB1LXVkaS0wID0gPDA+Ow0KCQkJeGxueCxhcHUtdWRpLTEgPSA8MD47DQoJCQl4bG54
LGFwdS11ZGktMTAgPSA8MD47DQoJCQl4bG54LGFwdS11ZGktMTEgPSA8MD47DQoJCQl4bG54LGFw
dS11ZGktMTIgPSA8MD47DQoJCQl4bG54LGFwdS11ZGktMTMgPSA8MD47DQoJCQl4bG54LGFwdS11
ZGktMTQgPSA8MD47DQoJCQl4bG54LGFwdS11ZGktMTUgPSA8MD47DQoJCQl4bG54LGFwdS11ZGkt
MiA9IDwwPjsNCgkJCXhsbngsYXB1LXVkaS0zID0gPDA+Ow0KCQkJeGxueCxhcHUtdWRpLTQgPSA8
MD47DQoJCQl4bG54LGFwdS11ZGktNSA9IDwwPjsNCgkJCXhsbngsYXB1LXVkaS02ID0gPDA+Ow0K
CQkJeGxueCxhcHUtdWRpLTcgPSA8MD47DQoJCQl4bG54LGFwdS11ZGktOCA9IDwwPjsNCgkJCXhs
bngsYXB1LXVkaS05ID0gPDA+Ow0KCQkJeGxueCxkY3ItYXV0b2xvY2stZW5hYmxlID0gPDE+Ow0K
CQkJeGxueCxkY3UtcmQtbGQtY2FjaGUtcGxiLXByaW8gPSA8MD47DQoJCQl4bG54LGRjdS1yZC1u
b25jYWNoZS1wbGItcHJpbyA9IDwwPjsNCgkJCXhsbngsZGN1LXJkLXRvdWNoLXBsYi1wcmlvID0g
PDA+Ow0KCQkJeGxueCxkY3UtcmQtdXJnZW50LXBsYi1wcmlvID0gPDA+Ow0KCQkJeGxueCxkY3Ut
d3ItZmx1c2gtcGxiLXByaW8gPSA8MD47DQoJCQl4bG54LGRjdS13ci1zdG9yZS1wbGItcHJpbyA9
IDwwPjsNCgkJCXhsbngsZGN1LXdyLXVyZ2VudC1wbGItcHJpbyA9IDwwPjsNCgkJCXhsbngsZG1h
MC1jb250cm9sID0gPDA+Ow0KCQkJeGxueCxkbWEwLXBsYi1wcmlvID0gPDA+Ow0KCQkJeGxueCxk
bWEwLXJ4Y2hhbm5lbGN0cmwgPSA8MTAxMDAwMD47DQoJCQl4bG54LGRtYTAtcnhpcnF0aW1lciA9
IDwzZmY+Ow0KCQkJeGxueCxkbWEwLXR4Y2hhbm5lbGN0cmwgPSA8MTAxMDAwMD47DQoJCQl4bG54
LGRtYTAtdHhpcnF0aW1lciA9IDwzZmY+Ow0KCQkJeGxueCxkbWExLWNvbnRyb2wgPSA8MD47DQoJ
CQl4bG54LGRtYTEtcGxiLXByaW8gPSA8MD47DQoJCQl4bG54LGRtYTEtcnhjaGFubmVsY3RybCA9
IDwxMDEwMDAwPjsNCgkJCXhsbngsZG1hMS1yeGlycXRpbWVyID0gPDNmZj47DQoJCQl4bG54LGRt
YTEtdHhjaGFubmVsY3RybCA9IDwxMDEwMDAwPjsNCgkJCXhsbngsZG1hMS10eGlycXRpbWVyID0g
PDNmZj47DQoJCQl4bG54LGRtYTItY29udHJvbCA9IDwwPjsNCgkJCXhsbngsZG1hMi1wbGItcHJp
byA9IDwwPjsNCgkJCXhsbngsZG1hMi1yeGNoYW5uZWxjdHJsID0gPDEwMTAwMDA+Ow0KCQkJeGxu
eCxkbWEyLXJ4aXJxdGltZXIgPSA8M2ZmPjsNCgkJCXhsbngsZG1hMi10eGNoYW5uZWxjdHJsID0g
PDEwMTAwMDA+Ow0KCQkJeGxueCxkbWEyLXR4aXJxdGltZXIgPSA8M2ZmPjsNCgkJCXhsbngsZG1h
My1jb250cm9sID0gPDA+Ow0KCQkJeGxueCxkbWEzLXBsYi1wcmlvID0gPDA+Ow0KCQkJeGxueCxk
bWEzLXJ4Y2hhbm5lbGN0cmwgPSA8MTAxMDAwMD47DQoJCQl4bG54LGRtYTMtcnhpcnF0aW1lciA9
IDwzZmY+Ow0KCQkJeGxueCxkbWEzLXR4Y2hhbm5lbGN0cmwgPSA8MTAxMDAwMD47DQoJCQl4bG54
LGRtYTMtdHhpcnF0aW1lciA9IDwzZmY+Ow0KCQkJeGxueCxlbmRpYW4tcmVzZXQgPSA8MD47DQoJ
CQl4bG54LGdlbmVyYXRlLXBsYi10aW1lc3BlY3MgPSA8MT47DQoJCQl4bG54LGljdS1yZC1mZXRj
aC1wbGItcHJpbyA9IDwwPjsNCgkJCXhsbngsaWN1LXJkLXNwZWMtcGxiLXByaW8gPSA8MD47DQoJ
CQl4bG54LGljdS1yZC10b3VjaC1wbGItcHJpbyA9IDwwPjsNCgkJCXhsbngsaW50ZXJjb25uZWN0
LWltYXNrID0gPGZmZmZmZmZmPjsNCgkJCXhsbngsbXBsYi1hbGxvdy1sb2NrLXhmZXIgPSA8MT47
DQoJCQl4bG54LG1wbGItYXJiLW1vZGUgPSA8MD47DQoJCQl4bG54LG1wbGItYXdpZHRoID0gPDIw
PjsNCgkJCXhsbngsbXBsYi1jb3VudGVyID0gPDUwMD47DQoJCQl4bG54LG1wbGItZHdpZHRoID0g
PDgwPjsNCgkJCXhsbngsbXBsYi1tYXgtYnVyc3QgPSA8OD47DQoJCQl4bG54LG1wbGItbmF0aXZl
LWR3aWR0aCA9IDw4MD47DQoJCQl4bG54LG1wbGItcDJwID0gPDA+Ow0KCQkJeGxueCxtcGxiLXBy
aW8tZGN1ciA9IDwyPjsNCgkJCXhsbngsbXBsYi1wcmlvLWRjdXcgPSA8Mz47DQoJCQl4bG54LG1w
bGItcHJpby1pY3UgPSA8ND47DQoJCQl4bG54LG1wbGItcHJpby1zcGxiMCA9IDwxPjsNCgkJCXhs
bngsbXBsYi1wcmlvLXNwbGIxID0gPDA+Ow0KCQkJeGxueCxtcGxiLXJlYWQtcGlwZS1lbmFibGUg
PSA8MT47DQoJCQl4bG54LG1wbGItc3luYy10YXR0cmlidXRlID0gPDA+Ow0KCQkJeGxueCxtcGxi
LXdkb2ctZW5hYmxlID0gPDE+Ow0KCQkJeGxueCxtcGxiLXdyaXRlLXBpcGUtZW5hYmxlID0gPDE+
Ow0KCQkJeGxueCxtcGxiLXdyaXRlLXBvc3QtZW5hYmxlID0gPDE+Ow0KCQkJeGxueCxudW0tZG1h
ID0gPDA+Ow0KCQkJeGxueCxwaXIgPSA8Zj47DQoJCQl4bG54LHBwYzQ0MG1jLWFkZHItYmFzZSA9
IDwwPjsNCgkJCXhsbngscHBjNDQwbWMtYWRkci1oaWdoID0gPGZmZmZmZmY+Ow0KCQkJeGxueCxw
cGM0NDBtYy1hcmItbW9kZSA9IDwwPjsNCgkJCXhsbngscHBjNDQwbWMtYmFuay1jb25mbGljdC1t
YXNrID0gPGMwMDAwMD47DQoJCQl4bG54LHBwYzQ0MG1jLWNvbnRyb2wgPSA8ZjgxMDAwOGY+Ow0K
CQkJeGxueCxwcGM0NDBtYy1tYXgtYnVyc3QgPSA8OD47DQoJCQl4bG54LHBwYzQ0MG1jLXByaW8t
ZGN1ciA9IDwyPjsNCgkJCXhsbngscHBjNDQwbWMtcHJpby1kY3V3ID0gPDM+Ow0KCQkJeGxueCxw
cGM0NDBtYy1wcmlvLWljdSA9IDw0PjsNCgkJCXhsbngscHBjNDQwbWMtcHJpby1zcGxiMCA9IDwx
PjsNCgkJCXhsbngscHBjNDQwbWMtcHJpby1zcGxiMSA9IDwwPjsNCgkJCXhsbngscHBjNDQwbWMt
cm93LWNvbmZsaWN0LW1hc2sgPSA8M2ZmZTAwPjsNCgkJCXhsbngscHBjZG0tYXN5bmNtb2RlID0g
PDA+Ow0KCQkJeGxueCxwcGNkcy1hc3luY21vZGUgPSA8MD47DQoJCQl4bG54LHVzZXItcmVzZXQg
PSA8MD47DQoJCX0gOw0KCX0gOw0KCXBsYl92NDZfMDogcGxiQDAgew0KCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCgkJI3NpemUtY2VsbHMgPSA8MT47DQoJCWNvbXBhdGlibGUgPSAieGxueCxwbGIt
djQ2LTEuMDMuYSIsICJzaW1wbGUtYnVzIjsNCgkJcmFuZ2VzIDsNCgkJRElQX1N3aXRjaGVzXzhC
aXQ6IGdwaW9AODE0NjAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJ4bG54LHhwcy1ncGlvLTEuMDAu
YSI7DQoJCQlyZWcgPSA8IDgxNDYwMDAwIDEwMDAwID47DQoJCQl4bG54LGFsbC1pbnB1dHMgPSA8
MT47DQoJCQl4bG54LGFsbC1pbnB1dHMtMiA9IDwwPjsNCgkJCXhsbngsZG91dC1kZWZhdWx0ID0g
PDA+Ow0KCQkJeGxueCxkb3V0LWRlZmF1bHQtMiA9IDwwPjsNCgkJCXhsbngsZmFtaWx5ID0gInZp
cnRleDUiOw0KCQkJeGxueCxncGlvLXdpZHRoID0gPDg+Ow0KCQkJeGxueCxpbnRlcnJ1cHQtcHJl
c2VudCA9IDwwPjsNCgkJCXhsbngsaXMtYmlkaXIgPSA8MT47DQoJCQl4bG54LGlzLWJpZGlyLTIg
PSA8MT47DQoJCQl4bG54LGlzLWR1YWwgPSA8MD47DQoJCQl4bG54LHRyaS1kZWZhdWx0ID0gPGZm
ZmZmZmZmPjsNCgkJCXhsbngsdHJpLWRlZmF1bHQtMiA9IDxmZmZmZmZmZj47DQoJCX0gOw0KCQlJ
SUNfRUVQUk9NOiBpMmNAODE2MDAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJ4bG54LHhwcy1paWMt
Mi4wMC5hIjsNCgkJCWludGVycnVwdC1wYXJlbnQgPSA8Jnhwc19pbnRjXzA+Ow0KCQkJaW50ZXJy
dXB0cyA9IDwgMSAyID47DQoJCQlyZWcgPSA8IDgxNjAwMDAwIDEwMDAwID47DQoJCQl4bG54LGNs
ay1mcmVxID0gPDVmNWUxMDA+Ow0KCQkJeGxueCxmYW1pbHkgPSAidmlydGV4NSI7DQoJCQl4bG54
LGdwby13aWR0aCA9IDwxPjsNCgkJCXhsbngsaWljLWZyZXEgPSA8MTg2YTA+Ow0KCQkJeGxueCxz
Y2wtaW5lcnRpYWwtZGVsYXkgPSA8MD47DQoJCQl4bG54LHNkYS1pbmVydGlhbC1kZWxheSA9IDww
PjsNCgkJCXhsbngsdGVuLWJpdC1hZHIgPSA8MD47DQoJCX0gOw0KCQlMRURzXzhCaXQ6IGdwaW9A
ODE0MDAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJ4bG54LHhwcy1ncGlvLTEuMDAuYSI7DQoJCQly
ZWcgPSA8IDgxNDAwMDAwIDEwMDAwID47DQoJCQl4bG54LGFsbC1pbnB1dHMgPSA8MD47DQoJCQl4
bG54LGFsbC1pbnB1dHMtMiA9IDwwPjsNCgkJCXhsbngsZG91dC1kZWZhdWx0ID0gPDA+Ow0KCQkJ
eGxueCxkb3V0LWRlZmF1bHQtMiA9IDwwPjsNCgkJCXhsbngsZmFtaWx5ID0gInZpcnRleDUiOw0K
CQkJeGxueCxncGlvLXdpZHRoID0gPDg+Ow0KCQkJeGxueCxpbnRlcnJ1cHQtcHJlc2VudCA9IDww
PjsNCgkJCXhsbngsaXMtYmlkaXIgPSA8MT47DQoJCQl4bG54LGlzLWJpZGlyLTIgPSA8MT47DQoJ
CQl4bG54LGlzLWR1YWwgPSA8MD47DQoJCQl4bG54LHRyaS1kZWZhdWx0ID0gPGZmZmZmZmZmPjsN
CgkJCXhsbngsdHJpLWRlZmF1bHQtMiA9IDxmZmZmZmZmZj47DQoJCX0gOw0KCQlMRURzX1Bvc2l0
aW9uczogZ3Bpb0A4MTQyMDAwMCB7DQoJCQljb21wYXRpYmxlID0gInhsbngseHBzLWdwaW8tMS4w
MC5hIjsNCgkJCXJlZyA9IDwgODE0MjAwMDAgMTAwMDAgPjsNCgkJCXhsbngsYWxsLWlucHV0cyA9
IDwwPjsNCgkJCXhsbngsYWxsLWlucHV0cy0yID0gPDA+Ow0KCQkJeGxueCxkb3V0LWRlZmF1bHQg
PSA8MD47DQoJCQl4bG54LGRvdXQtZGVmYXVsdC0yID0gPDA+Ow0KCQkJeGxueCxmYW1pbHkgPSAi
dmlydGV4NSI7DQoJCQl4bG54LGdwaW8td2lkdGggPSA8NT47DQoJCQl4bG54LGludGVycnVwdC1w
cmVzZW50ID0gPDA+Ow0KCQkJeGxueCxpcy1iaWRpciA9IDwxPjsNCgkJCXhsbngsaXMtYmlkaXIt
MiA9IDwxPjsNCgkJCXhsbngsaXMtZHVhbCA9IDwwPjsNCgkJCXhsbngsdHJpLWRlZmF1bHQgPSA8
ZmZmZmZmZmY+Ow0KCQkJeGxueCx0cmktZGVmYXVsdC0yID0gPGZmZmZmZmZmPjsNCgkJfSA7DQoJ
CVB1c2hfQnV0dG9uc181Qml0OiBncGlvQDgxNDQwMDAwIHsNCgkJCWNvbXBhdGlibGUgPSAieGxu
eCx4cHMtZ3Bpby0xLjAwLmEiOw0KCQkJcmVnID0gPCA4MTQ0MDAwMCAxMDAwMCA+Ow0KCQkJeGxu
eCxhbGwtaW5wdXRzID0gPDE+Ow0KCQkJeGxueCxhbGwtaW5wdXRzLTIgPSA8MD47DQoJCQl4bG54
LGRvdXQtZGVmYXVsdCA9IDwwPjsNCgkJCXhsbngsZG91dC1kZWZhdWx0LTIgPSA8MD47DQoJCQl4
bG54LGZhbWlseSA9ICJ2aXJ0ZXg1IjsNCgkJCXhsbngsZ3Bpby13aWR0aCA9IDw1PjsNCgkJCXhs
bngsaW50ZXJydXB0LXByZXNlbnQgPSA8MD47DQoJCQl4bG54LGlzLWJpZGlyID0gPDE+Ow0KCQkJ
eGxueCxpcy1iaWRpci0yID0gPDE+Ow0KCQkJeGxueCxpcy1kdWFsID0gPDA+Ow0KCQkJeGxueCx0
cmktZGVmYXVsdCA9IDxmZmZmZmZmZj47DQoJCQl4bG54LHRyaS1kZWZhdWx0LTIgPSA8ZmZmZmZm
ZmY+Ow0KCQl9IDsNCgkJUlMyMzJfVWFydF8xOiBzZXJpYWxAODNlMDAwMDAgew0KCQkJY2xvY2st
ZnJlcXVlbmN5ID0gPDVmNWUxMDA+Ow0KCQkJY29tcGF0aWJsZSA9ICJ4bG54LHhwcy11YXJ0MTY1
NTAtMi4wMC5hIiwgIm5zMTY1NTAiOw0KCQkJY3VycmVudC1zcGVlZCA9IDwyNTgwPjsNCgkJCWRl
dmljZV90eXBlID0gInNlcmlhbCI7DQoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ4cHNfaW50Y18w
PjsNCgkJCWludGVycnVwdHMgPSA8IDMgMiA+Ow0KCQkJcmVnID0gPCA4M2UwMDAwMCAxMDAwMCA+
Ow0KCQkJcmVnLW9mZnNldCA9IDwzPjsNCgkJCXJlZy1zaGlmdCA9IDwyPjsNCgkJCXhsbngsZmFt
aWx5ID0gInZpcnRleDUiOw0KCQkJeGxueCxoYXMtZXh0ZXJuYWwtcmNsayA9IDwwPjsNCgkJCXhs
bngsaGFzLWV4dGVybmFsLXhpbiA9IDwwPjsNCgkJCXhsbngsaXMtYS0xNjU1MCA9IDwxPjsNCgkJ
fSA7DQoJCVJTMjMyX1VhcnRfMjogc2VyaWFsQDgzZTIwMDAwIHsNCgkJCWNsb2NrLWZyZXF1ZW5j
eSA9IDw1ZjVlMTAwPjsNCgkJCWNvbXBhdGlibGUgPSAieGxueCx4cHMtdWFydDE2NTUwLTIuMDAu
YSIsICJuczE2NTUwIjsNCgkJCWN1cnJlbnQtc3BlZWQgPSA8MjU4MD47DQoJCQlkZXZpY2VfdHlw
ZSA9ICJzZXJpYWwiOw0KCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmeHBzX2ludGNfMD47DQoJCQlp
bnRlcnJ1cHRzID0gPCAyIDIgPjsNCgkJCXJlZyA9IDwgODNlMjAwMDAgMTAwMDAgPjsNCgkJCXJl
Zy1vZmZzZXQgPSA8Mz47DQoJCQlyZWctc2hpZnQgPSA8Mj47DQoJCQl4bG54LGZhbWlseSA9ICJ2
aXJ0ZXg1IjsNCgkJCXhsbngsaGFzLWV4dGVybmFsLXJjbGsgPSA8MD47DQoJCQl4bG54LGhhcy1l
eHRlcm5hbC14aW4gPSA8MD47DQoJCQl4bG54LGlzLWEtMTY1NTAgPSA8MT47DQoJCX0gOw0KCQlT
eXNBQ0VfQ29tcGFjdEZsYXNoOiBzeXNhY2VAODM2MDAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJ4
bG54LHhwcy1zeXNhY2UtMS4wMC5hIjsNCgkJCWludGVycnVwdC1wYXJlbnQgPSA8Jnhwc19pbnRj
XzA+Ow0KCQkJaW50ZXJydXB0cyA9IDwgMCAyID47DQoJCQlyZWcgPSA8IDgzNjAwMDAwIDEwMDAw
ID47DQoJCQl4bG54LGZhbWlseSA9ICJ2aXJ0ZXg1IjsNCgkJCXhsbngsbWVtLXdpZHRoID0gPDEw
PjsNCgkJfSA7DQoJCXhwc19icmFtX2lmX2NudGxyXzE6IHhwcy1icmFtLWlmLWNudGxyQGZmZmYw
MDAwIHsNCgkJCWNvbXBhdGlibGUgPSAieGxueCx4cHMtYnJhbS1pZi1jbnRsci0xLjAwLmEiOw0K
CQkJcmVnID0gPCBmZmZmMDAwMCAxMDAwMCA+Ow0KCQkJeGxueCxmYW1pbHkgPSAidmlydGV4NSI7
DQoJCX0gOw0KCQl4cHNfaW50Y18wOiBpbnRlcnJ1cHQtY29udHJvbGxlckA4MTgwMDAwMCB7DQoJ
CQkjaW50ZXJydXB0LWNlbGxzID0gPDI+Ow0KCQkJY29tcGF0aWJsZSA9ICJ4bG54LHhwcy1pbnRj
LTEuMDAuYSI7DQoJCQlpbnRlcnJ1cHQtY29udHJvbGxlciA7DQoJCQlyZWcgPSA8IDgxODAwMDAw
IDEwMDAwID47DQoJCQl4bG54LG51bS1pbnRyLWlucHV0cyA9IDw0PjsNCgkJfSA7DQoJfSA7DQp9
ICA7DQo=
------=_Part_32902_30000386.1217403892762--
