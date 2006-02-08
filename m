Return-Path: <bkartal@aselsan.com.tr>
Received: from turunc.aselsan.com.tr (mail.aselsan.com.tr [212.50.56.228])
	by ozlabs.org (Postfix) with ESMTP id 5932268AA3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 20:30:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-9"
Subject: powerCore 6750 nfs mount problem
Date: Wed, 8 Feb 2006 11:15:41 +0200
Message-ID: <C379193B17749F4BA82ABF87E7DCB6A62CF0D0@papatyaint.aselsan.com.tr>
From: "Bora KARTAL" <bkartal@aselsan.com.tr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to run linuxppc 2.4.20 with a nfs mounted root file system on=
=20a Force powerCore 6750 board with the following command-line options:

CONFIG_CMDLINE=3D"root=3D/dev/nfs nfsroot=3D15.20.11.58:/root/Linux/Monta=
Vista/opt/montavista/pro/devkit/ppc/7xx/target/ ip=3D15.20.8.204:15.20.11=
.58:15.20.0.0:255.255.0.0:test1:eth0:off"

I am giving a static IP to my target board so have no need to run DHCP cl=
ient on my target board.

My problem is:

The target can not mount to my server Linux machine and gives the followi=
ng error:

Looking up port of RPC 100003/2 on 15.20.11.58

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

I checked the nfs server at my host Linux and it is working properly. Any=
body can help?=20

Thanks,

Bora

######################################################################
Dikkat:

Bu elektronik posta mesaji kisisel ve ozeldir. Eger size=20
gonderilmediyse lutfen gondericiyi bilgilendirip mesaji siliniz.=20
Firmamiza gelen ve giden mesajlar virus taramasindan gecirilmekte,=20
guvenlik nedeni ile kontrol edilerek saklanmaktadir. Mesajdaki=20
gorusler ve bakis acisi gondericiye ait olup Aselsan A.S. resmi=20
gorusu olmak zorunda degildir.

######################################################################
Attention:=20

This e-mail message is privileged and confidential. If you are=20
not the intended recipient please delete the message and notify=20
the sender. E-mails to and from the company are monitored for=20
operational reasons and in accordance with lawful business practices.=20
Any views or opinions presented are solely those of the author and=20
do not necessarily represent the views of the company.

######################################################################
