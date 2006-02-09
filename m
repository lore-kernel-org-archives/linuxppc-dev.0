Return-Path: <David.Hunter@ipc.com>
Received: from stsnycon1.corp.root.ipc.com (ipcny.ipc.com [65.244.37.61])
	by ozlabs.org (Postfix) with ESMTP id EA41067A62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 01:44:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: powerCore 6750 nfs mount problem
Date: Thu, 9 Feb 2006 09:44:14 -0500
Message-ID: <9A63F321BC93984690A3CA6A1652C2ED0C1AD345@exnanycmbx1.corp.root.ipc.com>
From: "Hunter, David" <David.Hunter@ipc.com>
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

Bora,

> NETDEV WATCHDOG: eth0: transmit timed out=20

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
=09
<C379193B17749F4BA82ABF87E7DCB6A62CF0D0@papatyaint.aselsan.com.tr>
Content-Type: text/plain;	charset=3D"ISO-8859-9"

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
Anybody can help?=20

Thanks,

Bora



DISCLAIMER:
Important Notice *************************************************
This e-mail may contain information that is confidential, privileged or =
otherwise protected from disclosure. If you are not an intended =
recipient of this e-mail, do not duplicate or redistribute it by any =
means. Please delete it and any attachments and notify the sender that =
you have received it in error. Unintended recipients are prohibited from =
taking action on the basis of information in this e-mail.E-mail messages =
may contain computer viruses or other defects, may not be accurately =
replicated on other systems, or may be intercepted, deleted or =
interfered with without the knowledge of the sender or the intended =
recipient. If you are not comfortable with the risks associated with =
e-mail messages, you may decide not to use e-mail to communicate with =
IPC. IPC reserves the right, to the extent and under circumstances =
permitted by applicable law, to retain, monitor and intercept e-mail =
messages to and from its systems.
