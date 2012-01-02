Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
 [203.91.198.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91CF5B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 22:25:28 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: Mac address change in linux
Date: Mon, 2 Jan 2012 11:24:27 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE01C96A@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

When I execute below statements in linux to change the mac address I get the=
 error Host name look up error.
Below are the commands I execute to change the mac address and the console o=
utput.


1. ifconfig eth0.246 down
2. ifconfig eth0.246 hw ether 00:11:22:33:44:55
   ifconfig: hw: Host name lookup failure

sh-3.1# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:E0:EE:00:05:2E
          inet addr:172.16.52.20  Bcast:172.16.53.255  Mask:255.255.254.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:999 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:93661 (91.4 KiB)  TX bytes:0 (0.0 B)

eth0.246  Link encap:Ethernet  HWaddr 00:E0:EE:00:05:2E
          inet addr:172.16.52.20  Bcast:172.16.53.255  Mask:255.255.254.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:248 (248.0 B)  TX bytes:248 (248.0 B)

sh-3.1# ifconfig eth0.246 down
sh-3.1# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:E0:EE:00:05:2E
          inet addr:172.16.52.20  Bcast:172.16.53.255  Mask:255.255.254.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1005 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:94205 (91.9 KiB)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:248 (248.0 B)  TX bytes:248 (248.0 B)

sh-3.1# ifconfig eth0.246 hw ether 00:11:22:33:44:55 ifconfig eth0.246 up
ifconfig: hw: Host name lookup failure
sh-3.1# 


Regards,
Smitha
Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com
