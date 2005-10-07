Return-Path: <apoorvsangal@gmail.com>
Message-ID: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
Date: Fri, 7 Oct 2005 10:35:52 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_982_7768163.1128661552734"
Cc: sibi_mathew@satyam.com, vikrant_basotra@satyam.com,
	apoorv sangal <apoorv_sangal@satyam.com>
Subject: Problem Regarding Ping in Linux kernel version 2.4.24
Reply-To: apoorv sangal <apoorvsangal@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_982_7768163.1128661552734
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi All,
 I have ported Linux kernel version 2.4.24 on MPC8266 based customized
Board, having LXT971 ethernet chip.
The root file system is JFFS2 which i have made using mkfs.jffs2 utility
which comes along with the ELDK 3.0
In the kernel code i checked that there is support for the LXT971 chip, but
even after enabling all the network related funcuntionalities in the linux
kernel configuration, I am either not able to ping from the board to any
machine on the network, nor from the any other machine to the board.
The board is able to ping itself.
Can some one please throw some light why the board is not able to ping any
other machine.
 Regards
Apoorv Sangal

------=_Part_982_7768163.1128661552734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have ported L=
inux kernel version 2.4.24 on MPC8266 based customized Board, &nbsp;having =
LXT971 ethernet chip.</div>
<div>The root file system is JFFS2 which i have made using mkfs.jffs2 utili=
ty which comes along with the ELDK 3.0</div>
<div>In the kernel code i checked that there is support for the LXT971 chip=
, but even after enabling all the network related funcuntionalities in the =
linux kernel configuration, I&nbsp;am either not able to ping from the boar=
d to any machine on the network, nor from the any other machine to the boar=
d.
</div>
<div>The board is able to ping itself.</div>
<div>Can some one please throw some light why the board is not able to ping=
 any other machine.</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Apoorv Sangal</div>

------=_Part_982_7768163.1128661552734--
