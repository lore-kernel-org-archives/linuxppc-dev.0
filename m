Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 08208DDFB0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 07:29:30 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LgPcl-0002J8-0x
	for linuxppc-dev@ozlabs.org; Sun, 08 Mar 2009 13:29:27 -0700
Message-ID: <22402565.post@talk.nabble.com>
Date: Sun, 8 Mar 2009 13:29:27 -0700 (PDT)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Ethernet problem on 405EXr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm experiencing a strange problem with ethernet on custom
405EXr based board with 10/100 Micrel PHY in MII mode. I ran
u-boot 2009.01 and linux-2.6.27. In u-boot ethernet works flawlessly.
I didn't have to add any u-boot code to initialize the PHY. In linux
ethernet works only if there was some network activity in u-boot.
In this case NFS root works fine. Otherwise only TX side works
in Linux, ethtool does not report any errors, and resetting the PHY
via mii-tool doesn't help. Autonegotiation seems to work properly.
The only modification I did in linux is to change phy-mode to "mii"
in device tree.

Any help in debugging this is very much appreciated.

Felix.  
-- 
View this message in context: http://www.nabble.com/Ethernet-problem-on-405EXr-tp22402565p22402565.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
