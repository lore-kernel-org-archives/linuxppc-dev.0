Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C6EEDDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 05:20:41 +1000 (EST)
In-Reply-To: <1189877748.17593.9.camel@localhost.localdomain>
References: <20070915150901.AC712247CE@gemini.denx.de>
	<1189877748.17593.9.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <addcdbe0ab5b83aa58fc4e7df37b0925@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
Date: Sat, 15 Sep 2007 21:20:10 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Maybe we can have  U-Boot  add  the  partition  information  if  it's
>> missing in the device tree, and extend the mtdparts command in U-Boot
>> to add / adjust settings so they match what is defined in U-Boot.
>
> That would be great for newer U-Boots.  For existing older ones, it
> doesn't really solve the problem.  But then again, there's no way to
> possibly define all the partitioning schemes people may have adopted to
> their needs on their boards.  And I believe that is why David has
> RedBoot and command line partitioning override what is in the DTS 
> today.

Yeah, partitioning information really doesn't belong in the device
tree -- with the possible exception of the partitions that the
firmware (uboot in this case) needs to know about anyway.

You *can* put all partitioning info in the device tree, but that
doesn't mean you *should* :-)


Segher
