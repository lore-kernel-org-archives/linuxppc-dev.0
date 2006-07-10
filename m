Return-Path: <jxnuxdy@163.com>
Received: from m13-12.163.com (m13-12.163.com [220.181.13.12])
	by ozlabs.org (Postfix) with SMTP id B3F3367B67
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Jul 2006 21:41:50 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44B23CEF.0000D8.12869@bj163app12.163.com>
Date: Mon, 10 Jul 2006 19:41:35 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: "stefan roese" <sr@denx.de>,linuxppc-embedded@ozlabs.org
Subject: Re: Re: Failed to initialize the ethernet
  on PPC4 40GP
References: <44B220CB.000108.31873@bj163app12.163.com>
	<200607101242.29359.sr@denx.de>
In-Reply-To: <200607101242.29359.sr@denx.de>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_BEVThOPsLOXWODFuuaBRidvlwcMw"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_BEVThOPsLOXWODFuuaBRidvlwcMw
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Sorry, It is the UBoot question, I will address this to the UBoot maillist the next time!
After I add the environment valiable "ipaddr", this message disappeared,but the ethernet still not work (the MII on my custom board work on RMII mode).
u-boot => tftp 0x100000 u-boot.bin
miiphy_register: non unique device name 'ppc_4xx_eth0'
PHY speed read failed, assuming 10bT
PHY duplex read failed, assuming half duplex
ENET Speed is 10 Mbps - HALF duplex connection
TFTP from server 192.168.65.235; our IP address is 192.168.65.239
Filename 'u-boot.bin'.
Load address: 0x100000
Loading: T T T T T T T T T T 
Retry count exceeded; starting again
- Denny
--Boundary-=_BEVThOPsLOXWODFuuaBRidvlwcMw
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<P>Sorry, It is the UBoot question, I will address this to the UBoot mail=
list the next time!</P>
<P>After I add the environment valiable "ipaddr", this message disappeare=
d,but the ethernet still not work (the MII&nbsp;on&nbsp;my custom board w=
ork on RMII mode).</P>
<P>u-boot =3D&gt; tftp 0x100000 u-boot.bin<BR>miiphy_register: non unique=
 device name 'ppc_4xx_eth0'<BR>PHY speed read failed, assuming 10bT<BR>PH=
Y duplex read failed, assuming half duplex<BR>ENET Speed is 10 Mbps - HAL=
F duplex connection<BR>TFTP from server 192.168.65.235; our IP address is=
 192.168.65.239<BR>Filename 'u-boot.bin'.<BR>Load address: 0x100000<BR>Lo=
ading: T T T T T T T T T T <BR>Retry count exceeded; starting again</P>
<P>- Denny</P><br><!-- footer --><br><br><br><br><br><div style=3D"border=
-bottom:1px solid #999"></div><br>

=09<font color=3D"black" style=3D"font-size:14.8px">=CF=EB =D2=AA =CC=E5 =
=D1=E9 =D2=BB =CF=C2 =B3=AC =B4=F3 =B3=AC =BF=EC =B5=C4 =C3=E2 =B7=D1 =D3=
=CA =CF=E4 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=CD=F8 =D2=D7 3G =C3=E2 =B7=D1 =D3=CA =A3=
=AC=C7=C0 =D7=A2 =D4=D9 =B5=C3 280 =D5=D7 =B4=F3 =C8=DD =C1=BF =CD=F8 =C5=
=CC =A3=AC=BF=EC =C0=B4 =CC=E5 =D1=E9 =D3=CA =CF=E4 =BC=AB =CB=D9 =D6=AE =
=C2=C3
</a>


--Boundary-=_BEVThOPsLOXWODFuuaBRidvlwcMw--
