Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04EA7DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 16:26:48 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Jbqp2-0002b1-Kw
	for linuxppc-embedded@ozlabs.org; Tue, 18 Mar 2008 22:26:44 -0700
Message-ID: <16137363.post@talk.nabble.com>
Date: Tue, 18 Mar 2008 22:26:44 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
In-Reply-To: <16089631.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16089631.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,All

I found out what the problem was from.
When i set the Bus clock frequency to 50MHz and Processor clock Frequency
200MHz, opb_ethernet does not work with the driver.

And i check the driver,don't find the code base on the frequency . Anyone
knows the reason?



-- 
View this message in context: http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-xlnx-tp16089631p16137363.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
