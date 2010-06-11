Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BC139B7D8B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 23:46:07 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ON4Yf-00089t-8i
	for linuxppc-dev@ozlabs.org; Fri, 11 Jun 2010 06:46:05 -0700
Message-ID: <28855378.post@talk.nabble.com>
Date: Fri, 11 Jun 2010 06:46:05 -0700 (PDT)
From: "acrux@cruxppc.org" <acrux@linuxmail.org>
To: linuxppc-dev@ozlabs.org
Subject: powermac G5 fails to power off with 2.6.33.x and newer
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


hi all,
this powermac G5 ( PowerMac7,2 - dual 1.8 pci-x) fails to power off and just
stops there and after a minute or so the fans start to roar. Reboot works
fine.

Here my kernel config:
http://clinker.cruxppc.org/~acrux/config-2.6.33.5-powermacg5


thanks,
Nico

-- 
View this message in context: http://old.nabble.com/powermac-G5-fails-to-power-off-with-2.6.33.x-and-newer-tp28855378p28855378.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
