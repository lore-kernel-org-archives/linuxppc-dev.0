Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id 327471007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 22:14:52 +1000 (EST)
Received: by pzk30 with SMTP id 30so4237922pzk.15
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Aug 2010 05:14:50 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 6 Aug 2010 17:44:50 +0530
Message-ID: <AANLkTimb3D2UMHtfj_QiuA1GKW8vDcBSWKmxifNcMsWW@mail.gmail.com>
Subject: How to disable eTSEC2 in MPC837xerdb
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636459000189669048d269d03
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636459000189669048d269d03
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am trying to disable eTSEC2 in mpc8377erdb freescale board. I had removed
the entry corresponding to enet2 from the dts file and updated the firmware
to use the new dtb file. Now when I boot the board I can still see the eth1
entry in the ifconfig -a output. Is there something that I am missing.
Please advice.

Old dts: contains 2 entries enet0 and enet1*

*    enet0: ethernet@24000 {
      cell-index = <0>;
      device_type = "network";
      model = "eTSEC";
      compatible = "gianfar";
      reg = <0x24000 0x1000>;
      local-mac-address = [ 00 00 00 00 00 00 ];
      interrupts = <32 0x8 33 0x8 34 0x8>;
      phy-connection-type = "mii";
      interrupt-parent = <&ipic>;
      phy-handle = <&phy2>;
      sleep = <0xb00 0xc0000000>;
      fsl,magic-packet;
    };

    enet1: ethernet@25000 {
      cell-index = <1>;
      device_type = "network";
      model = "eTSEC";
      compatible = "gianfar";
      reg = <0x25000 0x1000>;
      local-mac-address = [ 00 00 00 00 00 00 ];
      interrupts = <35 0x8 36 0x8 37 0x8>;
      phy-connection-type = "mii";
      interrupt-parent = <&ipic>;
      fixed-link = <1 1 1000 0 0>;
      sleep = <0xb00 0x30000000>;
      fsl,magic-packet;
    };


New dts: single enet entry
*
*    enet0: ethernet@24000 {
      cell-index = <0>;
      device_type = "network";
      model = "eTSEC";
      compatible = "gianfar";
      reg = <0x24000 0x1000>;
      local-mac-address = [ 00 00 00 00 00 00 ];
      interrupts = <32 0x8 33 0x8 34 0x8>;
      phy-connection-type = "mii";
      interrupt-parent = <&ipic>;
      phy-handle = <&phy2>;
      sleep = <0xb00 0xc0000000>;
      fsl,magic-packet;
    };

Thanks in advance
Ravi Gupta

--001636459000189669048d269d03
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am trying to disable eTSEC2 in mpc8377erdb freescale board. I =
had removed the entry corresponding to enet2 from the dts file and updated =
the firmware to use the new dtb file. Now when I boot the board I can still=
 see the eth1 entry in the ifconfig -a output. Is there something that I am=
 missing. Please advice.<br>
<br>Old dts: contains 2 entries enet0 and enet1<b><br><br></b>=A0=A0=A0 ene=
t0: ethernet@24000 {<br>=A0=A0=A0=A0=A0 cell-index =3D &lt;0&gt;;<br>=A0=A0=
=A0=A0=A0 device_type =3D &quot;network&quot;;<br>=A0=A0=A0=A0=A0 model =3D=
 &quot;eTSEC&quot;;<br>=A0=A0=A0=A0=A0 compatible =3D &quot;gianfar&quot;;<=
br>
=A0=A0=A0=A0=A0 reg =3D &lt;0x24000 0x1000&gt;;<br>=A0=A0=A0=A0=A0 local-ma=
c-address =3D [ 00 00 00 00 00 00 ];<br>=A0=A0=A0=A0=A0 interrupts =3D &lt;=
32 0x8 33 0x8 34 0x8&gt;;<br>=A0=A0=A0=A0=A0 phy-connection-type =3D &quot;=
mii&quot;;<br>=A0=A0=A0=A0=A0 interrupt-parent =3D &lt;&amp;ipic&gt;;<br>
=A0=A0=A0=A0=A0 phy-handle =3D &lt;&amp;phy2&gt;;<br>=A0=A0=A0=A0=A0 sleep =
=3D &lt;0xb00 0xc0000000&gt;;<br>=A0=A0=A0=A0=A0 fsl,magic-packet;<br>=A0=
=A0=A0 };=A0 <br><br>=A0=A0=A0 enet1: ethernet@25000 {<br>=A0=A0=A0=A0=A0 c=
ell-index =3D &lt;1&gt;;<br>=A0=A0=A0=A0=A0 device_type =3D &quot;network&q=
uot;;<br>
=A0=A0=A0=A0=A0 model =3D &quot;eTSEC&quot;;<br>=A0=A0=A0=A0=A0 compatible =
=3D &quot;gianfar&quot;;<br>=A0=A0=A0=A0=A0 reg =3D &lt;0x25000 0x1000&gt;;=
<br>=A0=A0=A0=A0=A0 local-mac-address =3D [ 00 00 00 00 00 00 ];<br>=A0=A0=
=A0=A0=A0 interrupts =3D &lt;35 0x8 36 0x8 37 0x8&gt;;<br>
=A0=A0=A0=A0=A0 phy-connection-type =3D &quot;mii&quot;;<br>=A0=A0=A0=A0=A0=
 interrupt-parent =3D &lt;&amp;ipic&gt;;<br>=A0=A0=A0=A0=A0 fixed-link =3D =
&lt;1 1 1000 0 0&gt;; <br>=A0=A0=A0=A0=A0 sleep =3D &lt;0xb00 0x30000000&gt=
;;<br>=A0=A0=A0=A0=A0 fsl,magic-packet;<br>=A0=A0=A0 };=A0 <br>
<br><br>New dts: single enet entry<br><b><br>
</b>=A0=A0=A0 enet0: ethernet@24000 {<br>
=A0=A0=A0=A0=A0 cell-index =3D &lt;0&gt;;<br>
=A0=A0=A0=A0=A0 device_type =3D &quot;network&quot;;<br>
=A0=A0=A0=A0=A0 model =3D &quot;eTSEC&quot;;<br>
=A0=A0=A0=A0=A0 compatible =3D &quot;gianfar&quot;;<br>
=A0=A0=A0=A0=A0 reg =3D &lt;0x24000 0x1000&gt;;<br>
=A0=A0=A0=A0=A0 local-mac-address =3D [ 00 00 00 00 00 00 ];<br>
=A0=A0=A0=A0=A0 interrupts =3D &lt;32 0x8 33 0x8 34 0x8&gt;;<br>
=A0=A0=A0=A0=A0 phy-connection-type =3D &quot;mii&quot;;<br>
=A0=A0=A0=A0=A0 interrupt-parent =3D &lt;&amp;ipic&gt;;<br>
=A0=A0=A0=A0=A0 phy-handle =3D &lt;&amp;phy2&gt;;<br>
=A0=A0=A0=A0=A0 sleep =3D &lt;0xb00 0xc0000000&gt;;<br>
=A0=A0=A0=A0=A0 fsl,magic-packet;<br>
=A0=A0=A0 };=A0 <br>
<br>Thanks in advance<br>Ravi Gupta<br><br>

--001636459000189669048d269d03--
