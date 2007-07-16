Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E2FDDE20F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 01:38:23 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IASeR-0004Kl-1K
	for linuxppc-embedded@ozlabs.org; Mon, 16 Jul 2007 08:38:19 -0700
Message-ID: <11620099.post@talk.nabble.com>
Date: Mon, 16 Jul 2007 08:38:19 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ML410 PCI support
In-Reply-To: <11547023.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11547023.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



khollan wrote:
> 
> I have two questions:
> 1) Has anyone wrote linux 2.6 PCI drviers for the xilinx development
> boards.  I want to get the PCI slots working on my board.
> 2)How do I set the HwAddr for the TEMAC driver?  Im using Grants latest
> git tree.  My board boots and the HwAddr is set to 00:00:00:00:00:00
> Thanks for your help
> Kevin
> 

1) Still waiting to see if someone knows how to go about doing this...
2) Solved this by hardcoding it in the embed_config.c file

Any help would be appreciated for the PCI issue.
Kevin
-- 
View this message in context: http://www.nabble.com/ML410-PCI-support-tf4064052.html#a11620099
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
