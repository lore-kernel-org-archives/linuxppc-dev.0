Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D162679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 09:13:14 +1000 (EST)
In-Reply-To: <4278DDBF.8080705@ru.mvista.com>
References: <4278DDBF.8080705@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7bbdd4818c0ce43867d32ab3c1a317dc@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 4 May 2005 18:43:44 -0400
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice support
	for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 10:35 AM, Vitaly Bordug wrote:

> This patch contains actual Ethernet driver on platform bus. Currently 
> tested on MPC8272ADS  (PQII) board.

Hold off on this, please.

We need to get Panto to review it against the restructuring of all of 
the
existing drivers.

Thanks.


	-- Dan
