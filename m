Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 009B92BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 08:44:53 +1000 (EST)
In-Reply-To: <20041013212308.47899.qmail@web53804.mail.yahoo.com>
References: <20041013212308.47899.qmail@web53804.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D0DCDC9C-1D69-11D9-88FA-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 13 Oct 2004 18:47:09 -0400
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


On Oct 13, 2004, at 5:23 PM, annamaya wrote:

> I verified that the TX and RX clock signals are
> correct and the CMXFCR route register is programmed
> correctly for FCC2. I still see TX timeout errors. I
> am stumped. :-(

Do you have the FCC MAC set up properly for
full or half duplex?  If you don't have MDIO working,
you are going to have to force this to the proper
setting for your switch.  I mentioned this in a
previous message.

If that doesn't work, take a look at the CPM
memory map and ensure the "special" FCC
area is mapped properly.  I don't remember
if the 8280 has the "big" CPM like the 8260,
or the small one like the 8272.  There is
a configuration option that moves this memory
address for the FCC fifos and special buffers.


	-- Dan
