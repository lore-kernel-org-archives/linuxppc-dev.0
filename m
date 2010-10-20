Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37456B6EEE
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 17:55:13 +1100 (EST)
Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common to
	elbc devices
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A2B08A5@zch01exm23.fsl.freescale.net>
Date: Wed, 20 Oct 2010 01:54:53 -0500
Message-Id: <707F7370-D01B-462F-B896-D7F677AED8EB@kernel.crashing.org>
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>
	<2D2A6B88-DA17-467D-BB43-919C1CAAB894@kernel.crashing.org>
	<3850A844E6A3854C827AC5C0BEC7B60A2B08A5@zch01exm23.fsl.freescale.net>
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 20, 2010, at 12:12 AM, Zang Roy-R61911 wrote:

> 
> 
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, October 19, 2010 21:19 PM
>> To: Zang Roy-R61911
>> Cc: linux-mtd@lists.infradead.org; Wood Scott-B07421;
> dedekind1@gmail.com; Lan
>> Chunhe-B25806; linuxppc-dev@ozlabs.org; akpm@linux-foundation.org;
>> dwmw2@infradead.org; Gala Kumar-B11780
>> Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt
> common to
>> elbc devices
>> 
>> 
>> On Oct 18, 2010, at 2:22 AM, Roy Zang wrote:
>> 
>>> Move Freescale elbc interrupt from nand dirver to elbc driver.
>>> Then all elbc devices can use the interrupt instead of ONLY nand.
>>> 
>>> For former nand driver, it had the two functions:
>>> 
>>> 1. detecting nand flash partitions;
>>> 2. registering elbc interrupt.
>>> 
>>> Now, second function is removed to fsl_lbc.c.
>>> 
>>> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
>>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>>> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
>>> Cc: Wood Scott-B07421 <B07421@freescale.com>
>>> ---
>> 
>> Roy, this is a nit, but are these really p4080 specific?  just
> wondering why
>> the subject is P4080/eLBC:...
> We start these code in P4080 project. Some customer want to track eLBC
> error on P4080, but some of the code is limited in nand driver only ...
> That is why P4080/eLBC ...
> Roy

sure, but is anything about these patches p4080 specific?

- k
