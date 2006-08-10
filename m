Return-Path: <Prashant.Yendigeri@lntinfotech.com>
Received: from mail41.messagelabs.com (mail41.messagelabs.com [216.82.242.51])
	by ozlabs.org (Postfix) with SMTP id 4FD60679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 21:19:21 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different outputs
MIME-Version: 1.0
Message-ID: <OF403D77BC.13F5C3B5-ON652571C6.003D5A1C-652571C6.003E28AE@lntinfotech.com>
From: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
Date: Thu, 10 Aug 2006 16:48:56 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 003E28AA652571C6_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 003E28AA652571C6_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

The gianfar driver of 2.6.12 and 2.4.20 give different outputs on the same 
PPC 8540 board.

What could be the reason ? 

Output on 2.4.20 : 
/root # ifconfig eth0 172.28.8.254 up
eth0: PHY is Marvell 88E1011S (1410c62)
eth0: Auto-negotiation done
eth0: Half Duplex
eth0: Speed 10BT
eth0: Link is up

Output on 2.6.12
/ # ifconfig eth0 172.28.8.254 up
 eth0: PHY is Generic MII (ffffffff)

Kernel bootup mesages on 2.6.12 for eth initialisation :
[    1.706436] eth0: Gianfar Ethernet Controller Version 1.1, 
00:01:af:07:9b:8a

[    1.713769] eth0: Running with NAPI disabled
[    1.718137] eth0: 64/64 RX/TX BD ring size
[    1.722483] eth1: Gianfar Ethernet Controller Version 1.1, 
fd:e4:75:9d:72:6f

[    1.729812] eth1: Running with NAPI disabled
[    1.734180] eth1: 64/64 RX/TX BD ring size
[    1.738521] eth2: Gianfar Ethernet Controller Version 1.1, 
6f:74:3d:2f:64:65

[    1.745851] eth2: Running with NAPI disabled
[    1.750218] eth2: 64/64 RX/TX BD ring size

On 2.4.20 it is the same :
eth0: Gianfar Ethernet Controller Version 1.0, 00:01:af:07:9b:8a
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.0, fd:e4:75:9d:72:6f
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.0, 6f:74:3d:2f:64:65
eth2: Running with NAPI disabled
eth2: 64/64 RX/TX BD ring size

I am able to ping and use telnet,ftp etc when booted from 2.4.20 but ping, 
telnet,ftp, don't work eventhough i use same ramdisk in both the cases.
ifconfig shows card is up in 2.6.12 too.


Regards,
Prashant 







______________________________________________________________________
--=_alternative 003E28AA652571C6_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">The gianfar driver of 2.6.12 and 2.4.20
give different outputs on the same PPC 8540 board.</font>
<br>
<br><font size=2 face="sans-serif">What could be the reason ? </font>
<br>
<br><font size=2 face="sans-serif">Output on 2.4.20 : </font>
<br><font size=2 face="sans-serif">/root # ifconfig eth0 172.28.8.254 up</font>
<br><font size=2 face="sans-serif">eth0: PHY is Marvell 88E1011S (1410c62)</font>
<br><font size=2 face="sans-serif">eth0: Auto-negotiation done</font>
<br><font size=2 face="sans-serif">eth0: Half Duplex</font>
<br><font size=2 face="sans-serif">eth0: Speed 10BT</font>
<br><font size=2 face="sans-serif">eth0: Link is up</font>
<br>
<br><font size=2 face="sans-serif">Output on 2.6.12</font>
<br><font size=2 face="sans-serif">/ # ifconfig eth0 172.28.8.254 up</font>
<br><font size=2 face="sans-serif">&nbsp;eth0: PHY is Generic MII (ffffffff)</font>
<br>
<br><font size=2 face="sans-serif">Kernel bootup mesages on 2.6.12 for
eth initialisation :</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.706436] eth0: Gianfar
Ethernet Controller Version 1.1, 00:01:af:07:9b:8a</font>
<br>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.713769] eth0: Running
with NAPI disabled</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.718137] eth0: 64/64
RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.722483] eth1: Gianfar
Ethernet Controller Version 1.1, fd:e4:75:9d:72:6f</font>
<br>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.729812] eth1: Running
with NAPI disabled</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.734180] eth1: 64/64
RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.738521] eth2: Gianfar
Ethernet Controller Version 1.1, 6f:74:3d:2f:64:65</font>
<br>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.745851] eth2: Running
with NAPI disabled</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;1.750218] eth2: 64/64
RX/TX BD ring size</font>
<br>
<br><font size=2 face="sans-serif">On 2.4.20 it is the same :</font>
<br><font size=2 face="sans-serif">eth0: Gianfar Ethernet Controller Version
1.0, 00:01:af:07:9b:8a</font>
<br><font size=2 face="sans-serif">eth0: Running with NAPI disabled</font>
<br><font size=2 face="sans-serif">eth0: 64/64 RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">eth1: Gianfar Ethernet Controller Version
1.0, fd:e4:75:9d:72:6f</font>
<br><font size=2 face="sans-serif">eth1: Running with NAPI disabled</font>
<br><font size=2 face="sans-serif">eth1: 64/64 RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">eth2: Gianfar Ethernet Controller Version
1.0, 6f:74:3d:2f:64:65</font>
<br><font size=2 face="sans-serif">eth2: Running with NAPI disabled</font>
<br><font size=2 face="sans-serif">eth2: 64/64 RX/TX BD ring size</font>
<br>
<br><font size=2 face="sans-serif">I am able to ping and use telnet,ftp
etc when booted from 2.4.20 but ping, telnet,ftp, don't work eventhough
i use same ramdisk in both the cases.</font>
<br><font size=2 face="sans-serif">ifconfig shows card is up in 2.6.12
too.</font>
<br>
<br>
<br><font size=2 face="sans-serif">Regards,</font>
<br><font size=2 face="sans-serif">Prashant </font>
<br>
<br>
<br>
<br>
<br>
<br>

<BR>
______________________________________________________________________<BR>

--=_alternative 003E28AA652571C6_=--
