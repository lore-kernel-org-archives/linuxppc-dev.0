Return-Path: <ludovic.desroches@gmail.com>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.155])
	by ozlabs.org (Postfix) with ESMTP id 67A31DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 17:23:09 +1000 (EST)
Received: by po-out-1718.google.com with SMTP id y22so4205294pof.4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jun 2008 00:23:08 -0700 (PDT)
Message-ID: <388e90610806030023x4a2c1077hfbabb49b95853bd0@mail.gmail.com>
Date: Tue, 3 Jun 2008 09:23:07 +0200
From: "Ludovic Desroches" <ludovic.desroches@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: How accessing to my IP registers from Linux
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2599_25089911.1212477787610"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2599_25089911.1212477787610
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,



I have put xilinx kernel on my board : a memec FX12 based on a Virtex 4 FX.
Everything thing is OK, I have my serial console, Ethernet is also OK.

I have to make some drivers. For example one for the LCD screen. It is my
first driver so I want to try with something easier like LEDs. I know there
is a driver from Xilinx but I want to do it by myself. Moreover it is only =
a
file to adapt Xilinx standelone driver for Kernel.



I try to read and to write the registers of my GPIO IP which is working, I
have made some tests in standelone. How accessing to these registers ?

I have tried with this for example but without success :

ptr =3D ioremap_nocache(0x70001e00,0x00000004);
printk("GPIO_DATA (readl): %u\n",readl(ptr));



readl, outl, ioread32 : same result.



Thanks



Best Regards

--=20
Ludovic Desroches
Ing=E9nieur ESIEE 2008
mobile : 06 19 21 02 08
http://www.odulo.net

------=_Part_2599_25089911.1212477787610
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<p>Hi,</p><p>&nbsp;</p><p>I have put xilinx kernel on my board : a memec
FX12 based on a Virtex 4 FX. Everything thing is OK, I have my serial
console, Ethernet is also OK.</p><p>I have to make some drivers. For
example one for the LCD screen. It is my first driver so I want to try
with something easier like LEDs. I know there is a driver from Xilinx
but I want to do it by myself. Moreover it is only a file to adapt
Xilinx standelone driver for Kernel.</p><p>&nbsp;</p><p>I try to read and t=
o
write the registers of my GPIO IP which is working, I have made some
tests in standelone. How accessing to these registers ? </p><p>I have tried=
 with this for example but without success :</p><blockquote><p>ptr =3D iore=
map_nocache(0x70001e00,0x00000004);<br>printk(&quot;GPIO_DATA (readl): %u\n=
&quot;,readl(ptr)); </p>
<p>&nbsp;</p></blockquote><p>readl, outl, ioread32 : same result.</p><p>&nb=
sp;</p><p>Thanks</p><p>&nbsp;</p><p>Best Regards</p><br>-- <br>Ludovic Desr=
oches<br>Ing=E9nieur ESIEE 2008<br>mobile : 06 19 21 02 08<br><a href=3D"ht=
tp://www.odulo.net">http://www.odulo.net</a>

------=_Part_2599_25089911.1212477787610--
