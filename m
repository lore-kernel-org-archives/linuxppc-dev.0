MIME-Version: 1.0
Subject: How to configure 2 ethernet devices
Date: Wed, 15 May 2002 10:49:07 -0300
Message-ID: <B7AC573479F05C438F232539B961A168094FE9@CUR1006V.br002.siemens.net.br>
From: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Can anyone help me to configure two Ethernet devices in my custom board.
We use a MPC860T with FEC and SCC1 as Ethernet devices. FEC is eth0 and
SCC1 is eth1. We are also using Monta Vista HardHat Linux 2.0.
Linux kernel goes up with no problem, also the Ethernet devices but when
configuring the devices using bootp/rarpd in message IP-Config only
appears:

IP-Config: Got RARP answer form 10.0.0.10, my address is 10.0.0.100

I guess this is to the eth0 interface.
I suppose also the the Linux should ask an ip address to each interface
but it does not happen. By the way, each Ethernet interface has a its
own MAC address.
What do I need to configure in the HardHat Linux to receive a second ip
address to the eth1?
Many thanks.
Otavio Sugeno

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
