Return-Path: <dan@embeddededge.com>
Received: from smtp001.bizmail.yahoo.com (smtp001.bizmail.yahoo.com
	[216.136.172.125]) by ozlabs.org (Postfix) with SMTP id 0E3CC67A2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 02:43:55 +1100 (EST)
In-Reply-To: <4202408A.7050200@siemens.com>
References: <4202408A.7050200@siemens.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <754ecc31c2497b32a0c3f6df5ce21881@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 3 Feb 2005 10:43:55 -0500
To: Steffen Rumler <Steffen.Rumler@siemens.com>
Cc: linuxppc <linuxppc-embedded@ozlabs.org>
Subject: Re: uart.c: avoid changing parameter RAM on-the-fly for the console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 3, 2005, at 10:17 AM, Steffen Rumler wrote:

> According to Motorola this is _NOT_ allowed and dangerous.

:-)  yeah, ok ...

> I suggest to do this inside rs_8xx_init() and startup() as shown
> in the patch below.

would you please read Documentation/CodingStyle and
try sending the patch again?

Although it doesn't make too much difference in this case,
2.4.20 is pretty old and it helps to get patches against
the latest kernels.

> With this fix, the modules hanging before can boot now.

I suspect there is something else amiss, but I'll take a
look at it.  What is the speed of the processor and the
baud rate?

Thanks.

	-- Dan
