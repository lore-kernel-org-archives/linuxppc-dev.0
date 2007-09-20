Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070920012225.GG14404@localhost.localdomain>
References: <20070920012225.GG14404@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <93451aaa11582c2db3be55961514cce9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Cleanups for physmap_of.c (v2)
Date: Thu, 20 Sep 2007 19:11:59 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Vitaly Wool <vwool@ru.mvista.com>, David Woodhouse <dwmw2@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 	- (the big one) Despite the name, this driver really has
> nothing to do with drivers/mtd/physmap.c.  The fact that the flash
> chips must be physically direct mapped is a constrant, but doesn't
> really say anything about the actual purpose of this driver, which is
> to instantiate MTD devices based on information from the device tree.
> Therefore the physmap name is replaced everywhere within the file with
> "of_flash".

Do you think this code will handle NAND flash later, too?  If not,
maybe "of_norflash" is better?


Segher
