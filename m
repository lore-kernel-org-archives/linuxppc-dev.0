Return-Path: <luong.ngo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 6090C67C30
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 10:51:28 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id x19so582364pyg
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Nov 2006 15:51:27 -0800 (PST)
Message-ID: <1b2aacd80611061551t78cc4f1aoef66377e82c2daed@mail.gmail.com>
Date: Mon, 6 Nov 2006 15:51:24 -0800
From: "Luong Ngo" <luong.ngo@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: ethernet interface problem with kernel 2.6.14 on MPC8343E
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_80599_20402720.1162857084866"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_80599_20402720.1162857084866
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am having a problem with the interfaces eth0 and eth1 when running
2.6.14kernel on a board with MPC8343E. The problem I encounters is
only one of the
eth interface is really working. Only the one that is configured first,
using "ifconfig eth[0/1] 192.168.1.1 netmask 255.255.255.0" can ping and be
pinged from another host. I wonder if there is setup difference between the
TSEC1 and TSEC2 or this is not related to hardware but rather something in
the kernel. When I ping from other host, from within the Gianfar driver, I
can see the packet is received on both interfaces but only one responds.
When pinging from the system itself, only the working interface sending out
packet, the other interface does not send anything. Please advise me what I
am doing wrong or missing.

Thank you,
L. Ngo

------=_Part_80599_20402720.1162857084866
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I am having a problem with the interfaces eth0 and eth1 when running 2.6.14 kernel on a board with MPC8343E. The problem I encounters is only one of the eth interface is really working. Only the one that is configured first, using &quot;ifconfig eth[0/1] 
<a href="http://192.168.1.1">192.168.1.1</a> netmask <a href="http://255.255.255.0">255.255.255.0</a>&quot; can ping and be pinged from another host. I wonder if there is setup difference between the TSEC1 and TSEC2 or this is not related to hardware but rather something in the kernel. When I ping from other host, from within the Gianfar driver, I can see the packet is received on both interfaces but only one responds. When pinging from the system itself, only the working interface sending out packet, the other interface does not send anything. Please advise me what I am doing wrong or missing.
<br><br>Thank you,<br>L. Ngo<br>

------=_Part_80599_20402720.1162857084866--
