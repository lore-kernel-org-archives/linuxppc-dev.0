Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D72DD2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 07:17:10 +1000 (EST)
In-Reply-To: <20041013192135.72162.qmail@web53807.mail.yahoo.com>
References: <20041013192135.72162.qmail@web53807.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <913DC44A-1D5D-11D9-88FA-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 13 Oct 2004 17:19:29 -0400
To: annamaya <annamaya@yahoo.com>
Cc: Sam Song <samlinuxppc@yahoo.com.cn>, linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 13, 2004, at 3:21 PM, annamaya wrote:

> I looked at the driver again and it looks like the TX
> and RX clock signals are board specific. I will also
> have to program the CMXFCR clock route register with
> the appropriate clocks. Am I on the right track here?

Yep. :-)


	-- Dan
