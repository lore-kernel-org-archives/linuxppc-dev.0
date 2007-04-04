Return-Path: <david.lang@digitalinsight.com>
Received: from warden.diginsite.com (warden-p.diginsite.com [208.29.163.248])
	by ozlabs.org (Postfix) with SMTP id 832FEDDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 12:00:51 +1000 (EST)
Date: Tue, 3 Apr 2007 18:32:21 -0700 (PDT)
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <Pine.LNX.4.63.0704031817020.21680@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.63.0704031826000.21680@qynat.qvtvafvgr.pbz>
References: <1175644642.10567.31.camel@shinybook.infradead.org><200704032210
	02.GA13210@cynthia.pants.nu><1175648051.10567.61.camel@shinybook.infradead.
	org><20070403.181645.68159458.davem@davemloft.net><20070404022828.5c9b97f3@
	the-village.bc.nu><Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
	<20070404024400.56d016e1@the-village.bc.nu>
	<Pine.LNX.4.63.0704031817020.21680@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Apr 2007, David Lang wrote:

> so leave all the ports numbered 0-49, but let people who need to know run a 
> tool (even if it's dmesg -s 200000 |grep ttyS) to learn the details of what 
> hardware is used to run what port.

and by the way, this is exactly what I do on machines with different types of 
ethernet cards to figure out what ethX name the different types of cards get. 
after I've figured that out I learn which order the cards of that type are by 
plugging things into a port to see what shows up (knowing the MAC address 
doesn't do you any good if you don't know what hole to plug the wire into)

and yes, the nameing does get messed up when you plugin a new card, or enable a 
driver that you didn't have before, but as painful as that is it's pain that 
only I have to deal with when reconfiguring the hardware, all the other 
sysadmins who use the systems just know what port is what, they don't need to 
know that box A has tulip based quad cards while box B has starfire based quad 
cards, they just know 'eth0 is the one labled 0, eth18 is the one labled 18'

keep it simple for as many people as possible, don't spread the pain. those who 
will feel the pain are already dealing with it and the change to hardware-based 
named doesn't help them anyway.

David Lang
