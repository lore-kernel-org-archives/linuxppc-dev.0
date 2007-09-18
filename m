Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47DC8DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:08:53 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IXbsm-0004kX-1G
	for linuxppc-dev@ozlabs.org; Tue, 18 Sep 2007 05:08:48 -0700
Message-ID: <12755615.post@talk.nabble.com>
Date: Tue, 18 Sep 2007 05:08:48 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: multicasting in MPC8272ADS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


hi,

I have written a multicast test application in which there is a multicast
sender and receiver.
The multicast sender sends multicast packets on a specified interface and
the multicast 
receiver receives multicast packets. I have tested this application on my
network with
 x86 machines. But when I run a multicast receiver (which has been cross
compiled for 
MPC8272ADS) on my MPC board, it is unable to receive multicast packets (the
recvfrom 
call is waiting for ever for packets to arrive). The MPC board is able to
send multicast
packets to without any problems. The /proc/net/dev_mcast shows the
appropriate 
entries for the multicast address being enabled for the interface of
interest(esentially 
group joining appear to work).

My configuration is a MPC8272ADS board rp_filter =0 for all interfaces (ie
no source 
filtering).I am wondering where the problem could be, configurations or the
ethernet 
driver itself? Are there some known issues ?

By the way with loopback enabled the reception of packets works
in case the sender and receiver are on the same machine 

waiting for ur comments..

thnks

-- 
View this message in context: http://www.nabble.com/multicasting-in-MPC8272ADS-tf4473829.html#a12755615
Sent from the linuxppc-dev mailing list archive at Nabble.com.
