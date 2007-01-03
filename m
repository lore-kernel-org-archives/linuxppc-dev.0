Return-Path: <n.balaji@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 5CB6CDDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Jan 2007 23:03:33 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 5FE008780C7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Jan 2007 03:03:00 -0800 (PST)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r713030300-01-2
	for linuxppc-embedded@ozlabs.org; Wed, 03 Jan 2007 03:03:00 -0800
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id C0EE88780B7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Jan 2007 03:02:59 -0800 (PST)
Message-ID: <5380.202.144.30.226.1167822482.squirrel@mail.gdatech.co.in>
Date: Wed, 3 Jan 2007 16:38:02 +0530 (IST)
Subject: Asynchronous Crypto suppor for MPC8360E's Security Engine
From: n.balaji@gdatech.co.in
To: ilugc@ae.iitm.ac.in,linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
References: 
In-Reply-To: 
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
  I am working on MPC8360E Security Engine. I have ported the Openswan
2.4.5(IPSec --KLIPS) with OCF to MPC8360E's Security Engine (Talitos).
Encryption and Decryption is working. But when I check the performance of
Talitos with netio benchmark Tool, IPSec S/W Algorithms is giving more
bandwidth than Talitos.
  I do not know that why Talitos is giving less bandwidth and any probelm
in Openswan or OCF or Talitos driver or Talitos H/W. Please give your
suggestions and if you have any link related to Talitos, send to me.
If you know any benchmark tool like netio, inform to me.

  Linux kernel version is 2.6.11.

  I tested the IPSec performance by netio tool. The output is

Without IPSec :
-------------
Packet size  1k bytes:  8735 KByte/s Tx,  11242 KByte/s Rx.
Packet size  2k bytes:  8723 KByte/s Tx,  11001 KByte/s Rx.
Packet size  4k bytes:  8730 KByte/s Tx,  10159 KByte/s Rx.
Packet size  8k bytes:  8762 KByte/s Tx,  10986 KByte/s Rx.
Packet size 16k bytes:  8725 KByte/s Tx,  10997 KByte/s Rx.
Packet size 32k bytes:  8725 KByte/s Tx,  11002 KByte/s Rx.

IPSec in S/W :
------------
Packet size  1k bytes:  884 KByte/s Tx,  1120 KByte/s Rx.
Packet size  2k bytes:  1234 KByte/s Tx,  1149 KByte/s Rx.
Packet size  4k bytes:  1209 KByte/s Tx,  1178 KByte/s Rx.
Packet size  8k bytes:  885 KByte/s Tx,  1155 KByte/s Rx.
Packet size 16k bytes:  1184 KByte/s Tx,  1197 KByte/s Rx.
Packet size 32k bytes:  1194 KByte/s Tx,  1206 KByte/s Rx.

IPSec in H/W :
-------------
Packet size  1k bytes:  55978 Byte/s Tx,  484 KByte/s Rx.
Packet size  2k bytes:  57685 Byte/s Tx,  577 KByte/s Rx.
Packet size  4k bytes:  57344 Byte/s Tx,  812 KByte/s Rx.
Packet size  8k bytes:  58709 Byte/s Tx,  438 KByte/s Rx.
Packet size 16k bytes:  60074 Byte/s Tx,  627 KByte/s Rx.
Packet size 32k bytes:  60072 Byte/s Tx,  575 KByte/s Rx.

 I sholud get more bandwidth when I test through IPSec H/W. But I am
getting less bandwidth compare to IPSec S/W.

 But When I transmit 32 MB size file through tftp, it is transmitted in
139.0 seconds in IPSec S/W. When we transmit the same file, it is
transmitted in 136.2 seconds in IPSec H/W.

 When I ping the system, I got the reply in 2ms in IPSec S/W and 1ms in
IPSec H/W.

-Thanks
 N.Balaji
