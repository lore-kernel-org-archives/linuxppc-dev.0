Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 61F9EDDF00
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 07:37:30 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K3HiY-0002jU-Ek
	for linuxppc-embedded@ozlabs.org; Mon, 02 Jun 2008 14:37:26 -0700
Message-ID: <17611404.post@talk.nabble.com>
Date: Mon, 2 Jun 2008 14:37:26 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: XLlTemac port forwarding probelm?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi everyone,

I'm using my custom Xilinx board as a gateway for a networked webcam.  The
board is based on the ml410.  Basically eth1 is connected to the outside
world and eth0 is connected to the webcam.  I'm port forwarding port 80 with
iptables.  I can connect to the webcams web server by going to the IP
address of the Xilinx board just fine, but here comes my problem...

After the first initial load, which is relatively fast, all subsequent
refreshes become ungodly slow.  If I ifconfig down eth1 and bring it back up
the next refresh is fast again.  

I'm using Xilinx's Local Link Mac with the Fifo interface instead of DMA. 
Any ideas of whats going on?

Thanks

Kevin
-- 
View this message in context: http://www.nabble.com/XLlTemac-port-forwarding-probelm--tp17611404p17611404.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
