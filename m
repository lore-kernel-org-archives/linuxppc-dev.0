Return-Path: <vneethv@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73CCCB7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 16:50:16 +1000 (EST)
Received: by fxh10 with SMTP id 10so5720778fxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Aug 2011 23:50:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFbQSaAhXUrb1peJ2E3Kkp1gd16JSn9OjneO826q_aMz+yzAqg@mail.gmail.com>
References: <OFABB45B91.59E6539A-ONCA2578CC.006F5FB7-CA2578CC.0070CFA6@csc.com>
	<CAFbQSaDaL0UaiY4r+u=a72mmsCHxs7O5Z82MESrXXcWj2tNvbQ@mail.gmail.com>
	<OF7A7D0C50.273D2A69-ONCA2578CD.001B5783-CA2578CD.001D9FFE@csc.com>
	<CAFbQSaAhXUrb1peJ2E3Kkp1gd16JSn9OjneO826q_aMz+yzAqg@mail.gmail.com>
From: Vineeth <vneethv@gmail.com>
Date: Tue, 2 Aug 2011 12:19:51 +0530
Message-ID: <CAFbQSaC6BkZj+a4=-9Q2Cyj7w=4y5QYM22kaK1O=Uz5KW9iiuQ@mail.gmail.com>
Subject: Fwd: MPC7410 Linux Kernel
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=bcaec554000cbc4c6f04a9802828
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec554000cbc4c6f04a9802828
Content-Type: multipart/alternative; boundary=bcaec554000cbc4c5704a9802826

--bcaec554000cbc4c5704a9802826
Content-Type: text/plain; charset=ISO-8859-1

Hi,

We are trying to port  linux 2.6.38 on MPC7410 based board (This is a
preparatory design by our customer)

System architecture is as follows,

MPC7410 <=> MPC107 <=> PCI_to_LOCAL(plx9052) <=> UART

Previously we were using ppc architecture and we had some issues with
page_init() functions; which may be because of our configuration.As we didnt
get much support on ppc architecture we moved to powerpc.

Now we moved to powerpc architecture. We have some doubts on writing the dts
file. Please find the dts file attached.

when we checked the legacy_serial.c file, we found that
legacy_serial_parents not expecting a pci-local or a pci bridge as parent.
is our understanding correct ? should we introduce a new pci parent in that
structure ?

 We are confused about writing the ranges property of PCI node.we were
referring booting_without_of doc but didnt get much info. Is there any file
which gives better idea about the ranges property ?

Thanks
 Vineeth

--bcaec554000cbc4c5704a9802826
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><span style=3D"font-family:trebuchet ms,sans=
-serif;color:rgb(0, 0, 102)">Hi,</span><br style=3D"font-family:trebuchet m=
s,sans-serif;color:rgb(0, 0, 102)"><br style=3D"font-family:trebuchet ms,sa=
ns-serif;color:rgb(0, 0, 102)">


<span style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">We=
 are trying to port=A0 linux 2.6.38 on MPC7410 based board (This is a prepa=
ratory design by our customer) </span><br style=3D"font-family:trebuchet ms=
,sans-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">System=
 architecture is as follows,</span><br style=3D"font-family:trebuchet ms,sa=
ns-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">MPC741=
0 &lt;=3D&gt; MPC107 &lt;=3D&gt; PCI_to_LOCAL(plx9052) &lt;=3D&gt; UART</sp=
an><br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">Previo=
usly we were using ppc architecture and we had some issues with page_init()=
 functions; which may be because of our configuration.As we didnt get much =
support on ppc architecture we moved to powerpc.</span><br style=3D"font-fa=
mily:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">Now we=
 moved to powerpc architecture. We have some doubts on writing the dts file=
. Please find the dts file attached.</span><br style=3D"font-family:trebuch=
et ms,sans-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">when w=
e checked the legacy_serial.c file, we found that legacy_serial_parents not=
 expecting a pci-local or a pci bridge as parent. is our understanding corr=
ect ? should we introduce a new pci parent in that structure ?</span><br st=
yle=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">=A0We =
are confused about writing the ranges property of PCI node.we were referrin=
g booting_without_of doc but didnt get much info. Is there any file which g=
ives better idea about the ranges property ?</span><br style=3D"font-family=
:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">


<br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)"><spa=
n style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">Thanks=
</span><br style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102=
)">

<font color=3D"#888888">
<span style=3D"font-family:trebuchet ms,sans-serif;color:rgb(0, 0, 102)">Vi=
neeth</span></font><div><div></div><div class=3D"h5"><br></div></div></div>=
<br>

--bcaec554000cbc4c5704a9802826--

--bcaec554000cbc4c6f04a9802828
Content-Type: application/octet-stream; name="obc7410.dts"
Content-Disposition: attachment; filename="obc7410.dts"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqui3oon1

LyoKICogRGV2aWNlIFRyZWUgU291Y2UgZm9yIE9CQzc0MTAtQ29yZUVsCiAqCiAqIENob29zZSBD
T05GSUdfTVBDNzQxMCB0byBidWlsZCBhIGtlcm5lbCBmb3IgT0JDNzQxMCwgb3IgdXNlCiAqIHRo
ZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb24gbXBjNzQxMF9kZWZjb25maWcuCiAqCiAqIEJhc2VkIG9u
IGt1cm9ib3hIRy5kdHMKICoKICogMjAxMSAoYykgVmluZWV0aC9TdW1lc2gKICogQ29weXJpZ2h0
IDIwMTEgQ29yZUVsIHRlY2hub2xvZ2llcwogKgogKiBUaGlzIGZpbGUgaXMgbGljZW5zZWQgdW5k
ZXIKICogdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9u
IDIuICBUaGlzIHByb2dyYW0KICogaXMgbGljZW5zZWQgImFzIGlzIiB3aXRob3V0IGFueSB3YXJy
YW50eSBvZiBhbnkga2luZCwgd2hldGhlciBleHByZXNzCiAqIG9yIGltcGxpZWQuCgoKICovCi9k
dHMtdjEvOwovIHsKCW1vZGVsID0gIm9iYzc0MTAiOwoJY29tcGF0aWJsZSA9ICJtcGM3NDEwIjsK
CSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJI3NpemUtY2VsbHMgPSA8MT47CgoJYWxpYXNlcyB7CgkJ
c2VyaWFsMCA9ICZzZXJpYWwwOwoJCXBjaTAgPSAmcGNpMDsKCX07CgoKCWNwdXMgewoJCSNhZGRy
ZXNzLWNlbGxzID0gPDE+OwoJCSNzaXplLWNlbGxzID0gPDA+OwoJCVBvd2VyUEMsNjAzZSB7IC8q
IFJlYWxseSA3NDEwICovCgkJCWRldmljZV90eXBlID0gImNwdSI7CgkJCXJlZyA9IDwweDA+OwoJ
CQljbG9jay1mcmVxdWVuY3kgPSA8MjY2MDAwMDAwPjsJLyogRml4ZWQgYnkgYm9vdGxvYWRlciAq
LwoJCQl0aW1lYmFzZS1mcmVxdWVuY3kgPSA8MzI1MjIyNDA+OyAvKiBGaXhlZCBieSBib290bG9h
ZGVyICovCgkJCWJ1cy1mcmVxdWVuY3kgPSA8MD47CQkvKiBGaXhlZCBieSBib290bG9hZGVyICov
CgkJCS8qIEZvbGxvd2luZyByZXF1aXJlZCBieSBkdGMgYnV0IG5vdCB1c2VkICovCgkJCWktY2Fj
aGUtc2l6ZSA9IDwweDQwMDA+OwoJCQlkLWNhY2hlLXNpemUgPSA8MHg0MDAwPjsKCQl9OwoJfTsK
CgltZW1vcnkgewoJCWRldmljZV90eXBlID0gIm1lbW9yeSI7CgkJcmVnID0gPDB4MCAweDQwMDAw
MDA+OwoJfTsKCglzb2MxMHggeyAvKiBBRkFJQ1QgaSBnb3QgaXQgZnJvbSBLVVJPQk9YSEcgOikg
Ki8KCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQlkZXZpY2Vf
dHlwZSA9ICJzb2MiOwoJCWNvbXBhdGlibGUgPSAibXBjMTB4IjsKCQlzdG9yZS1nYXRoZXJpbmcg
PSA8MD47IC8qIDAgPT0gb2ZmLCAhMCA9PSBvbiAqLwoJCXJlZyA9IDwweDgwMDAwMDAwIDB4MTAw
MDAwPjsKCQlyYW5nZXMgPSA8MHg4MDAwMDAwMCAweDgwMDAwMDAwIDB4NzAwMDAwMDAJLyogcGNp
IG1lbSBzcGFjZSAqLwoJCQkgICAgICAweGZjMDAwMDAwIDB4ZmMwMDAwMDAgMHgxMDAwMDAJLyog
RVVNQiAqLwogICAgICAgICAgICAgICAgICAweGZlMDAwMDAwIDB4ZmUwMDAwMDAgMHhjMDAwMDAJ
LyogcGNpIGkvbyBzcGFjZSAqLwogICAgICAgICAgICAgICAgICAweGZlYzAwMDAwIDB4ZmVjMDAw
MDAgMHgzMDAwMDAJLyogcGNpIGNmZyByZWdzICovCiAgICAgICAgICAgICAgICAgIDB4ZmVmMDAw
MDAgMHhmZWYwMDAwMCAweDEwMDAwMD47CS8qIHBjaSBpYWNrICovCgoJCQltcGljOiBpbnRlcnJ1
cHQtY29udHJvbGxlckA4MDA0MDAwMCB7CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47CgkJCSNh
ZGRyZXNzLWNlbGxzID0gPDA+OwoJCQlkZXZpY2VfdHlwZSA9ICJvcGVuLXBpYyI7CgkJCWNvbXBh
dGlibGUgPSAiY2hycCxvcGVuLXBpYyI7CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQlyZWcg
PSA8MHg4MDA0MDAwMCAweDQwMDAwPjsKICAgIAkJfTsKCgkJcGNpMDogcGNpQGZlYzAwMDAwIHsK
CQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJCSNzaXplLWNlbGxzID0gPDI+OwoJCQkjaW50ZXJy
dXB0LWNlbGxzID0gPDE+OwoJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJCQljb21wYXRpYmxlID0g
Im1wYzEweC1wY2kiOwoJCQlyZWcgPSA8MHhmZWMwMDAwMCAweDQwMDAwMD47CgkJCXJhbmdlcyA9
IDwweDEwMDAwMDAgMHgwIDB4MCAweGZlMDAwMDAwIDB4MCAweGMwMDAwMAogICAgICAgICAgICAg
ICAgICAgICAgMHgyMDAwMDAwIDB4MCAweDgwMDAwMDAwIDB4ODAwMDAwMDAgMHgwIDB4NzAwMDAw
MDA+OwoJCQlidXMtcmFuZ2UgPSA8MCAyNTU+OwoJCQljbG9jay1mcmVxdWVuY3kgPSA8MTMzMzMz
MzMzPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCWludGVycnVwdC1tYXAtbWFz
ayA9IDwweGY4MDAgMHgwIDB4MCAweDc+OwogICAgICAgCiAgICAgICAJCQlwY2kybG9jYWw6IHBj
aUxvY2FsQDB4ZGIwMDAwMDAgewoJCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47CgkJCQkjc2l6ZS1j
ZWxscyA9IDwyPjsKCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJCQlkZXZpY2UtdHlwZSA9
ICJwY2ktbG9jYWwiOyAKCQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7CiAgICAgICAgICAg
ICAgICByZWcgPSA8MHhkYjAwMDEwMCAweDEwMDA+OwogICAgCiAgICAgICAgICAgICAgICAgICBz
ZXJpYWwwOiBzZXJpYWxAMHgxMDAgewogICAgICAgICAgICAgICAgICAgICBjZWxsLWluZGV4ID0g
PDE+OwogICAgICAgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJzZXJpYWwiOwogICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm5zMTY1NTAiOwogICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8MHgxMDAgMHgxMDAwPjsKICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVl
bmN5ID0gPDEzMDA0MTAwMD47CiAgICAgICAgICAgICAgICAgICAgIGN1cnJlbnQtc3BlZWQgPSA8
NTc2MDA+OwogICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDEwIDA+OwogICAgICAg
ICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKICAgICAgICAgICAgICAg
ICB9OwogICAgICAgICAgICB9OyAKCgoJCX07Cgl9Owp9Owo=
--bcaec554000cbc4c6f04a9802828--
