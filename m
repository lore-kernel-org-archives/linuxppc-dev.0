Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B6F8DDFE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 00:40:16 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Htlow-0003RC-Vx
	for linuxppc-embedded@ozlabs.org; Thu, 31 May 2007 07:40:10 -0700
Message-ID: <10895279.post@talk.nabble.com>
Date: Thu, 31 May 2007 07:40:10 -0700 (PDT)
From: Guillaume Berthelom <guillaume.berthelom@cleode.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx ethernet EMAC and bad checksum?
In-Reply-To: <10890962.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10890962.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I found the answer just after send my post!
I had  NETIF_F_IP_CSUM in my ndev->feature 

-- 
View this message in context: http://www.nabble.com/Xilinx-ethernet-EMAC-and-bad-checksum--tf3845670.html#a10895279
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
