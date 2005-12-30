Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 51D7168949
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 05:36:11 +1100 (EST)
Date: Fri, 30 Dec 2005 10:36:08 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Kiran Kumar.A" <kiranf5@lycos.com>
Message-ID: <20051230183608.GA2376@gate.ebshome.net>
References: <20051230112111.58191CA092@ws7-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051230112111.58191CA092@ws7-4.us4.outblaze.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Regarding booting 440 gr board / ibm emac driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Dec 30, 2005 at 06:21:11AM -0500, Kiran Kumar.A wrote:
> Hello Benjamin,
> This is kiran here. I'm working on 440GR (Yosemite) board to boot linux-2.6.13.4.
> Everything works fine execpt for MAC address. I saw the code in arch/ppc/platforms/4xx/yosemite.c; the code to copy the MAC addr from board info structure seems to be in place. I am  using IBM emac driver written by you.
> Linux boots up fine and  in the booting messages , I see that the MAC addr is displayed as all zeroes. Also, the ifconfig displays the MAC address as all zeroes.  
> 
> Could you please throw some light on the same. 

First, check that the code which copies MAC address is actually 
executed. Second, check _what_ is being copied by this code. Maybe 
board info structure contains zeros.

> Do we need to modify the driver for MAC address issue??

No, you don't need to modify EMAC driver.

-- 
Eugene
