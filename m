Return-Path: <bkartal@aselsan.com.tr>
Received: from turunc.aselsan.com.tr (mail.aselsan.com.tr [212.50.56.228])
	by ozlabs.org (Postfix) with ESMTP id 2C16E67B30
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 19:04:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-9"
Subject: YNT: powerCore 6750 nfs mount problem
Date: Fri, 10 Feb 2006 10:03:15 +0200
Message-ID: <C379193B17749F4BA82ABF87E7DCB6A62CF0D2@papatyaint.aselsan.com.tr>
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

Hi David,
Unfortunately I am not using u-boot. I think this is not a physical link =
problem. Becouse in the bootup phase it gets the the lsp via ftp correctl=
y. But I thought that this errror is somehow board specific, because when=
=20I tried the same configuration with another target board (Motorolla MV=
ME5100) it successfully mount to the root file system. =20

________________________________

Kimden: linuxppc-embedded-bounces@ozlabs.org bu ki=FEinin yerine: Hunter,=
=20David
G=F6nderilmi=FE: Per 09.02.2006 16:44
Kime: linuxppc-embedded@ozlabs.org
Konu: RE: powerCore 6750 nfs mount problem



Bora,

> NETDEV WATCHDOG: eth0: transmit timed out

This usually means the Ethernet driver's transmitter is stuck.  Did it
initialize correctly?  Did the PHY go link up?

How does network behave in your bootloader?  (Hopefully you're using
U-Boot. :)

-Dave

-----Original Message-----
Date: Wed, 8 Feb 2006 11:15:41 +0200
From: "Bora KARTAL" <bkartal@aselsan.com.tr>
Subject: powerCore 6750 nfs mount problem
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
=20     =20
<C379193B17749F4BA82ABF87E7DCB6A62CF0D0@papatyaint.aselsan.com.tr>
Content-Type: text/plain;       charset=3D"ISO-8859-9"

Hi,

I am trying to run linuxppc 2.4.20 with a nfs mounted root file system
on a Force powerCore 6750 board with the following command-line options:

CONFIG_CMDLINE=3D"root=3D/dev/nfs
nfsroot=3D15.20.11.58:/root/Linux/MontaVista/opt/montavista/pro/devkit/pp=
c
/7xx/target/
ip=3D15.20.8.204:15.20.11.58:15.20.0.0:255.255.0.0:test1:eth0:off"

I am giving a static IP to my target board so have no need to run DHCP
client on my target board.

My problem is:

The target can not mount to my server Linux machine and gives the
following error:

Looking up port of RPC 100003/2 on 15.20.11.58

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

NETDEV WATCHDOG: eth0: transmit timed out

I checked the nfs server at my host Linux and it is working properly.
Anybody can help?

Thanks,

Bora



DISCLAIMER:
Important Notice *************************************************
This e-mail may contain information that is confidential, privileged or o=
therwise protected from disclosure. If you are not an intended recipient =
of this e-mail, do not duplicate or redistribute it by any means. Please =
delete it and any attachments and notify the sender that you have receive=
d it in error. Unintended recipients are prohibited from taking action on=
=20the basis of information in this e-mail.E-mail messages may contain co=
mputer viruses or other defects, may not be accurately replicated on othe=
r systems, or may be intercepted, deleted or interfered with without the =
knowledge of the sender or the intended recipient. If you are not comfort=
able with the risks associated with e-mail messages, you may decide not t=
o use e-mail to communicate with IPC. IPC reserves the right, to the exte=
nt and under circumstances permitted by applicable law, to retain, monito=
r and intercept e-mail messages to and from its systems.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


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
