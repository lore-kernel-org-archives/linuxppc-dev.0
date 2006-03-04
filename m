Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id BC0E667A39
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Mar 2006 04:11:15 +1100 (EST)
In-Reply-To: <4A062D477D842B4C8FC48EA5AF2D41F201C47BE3@us-bv-m23.global.tektronix.net>
References: <4A062D477D842B4C8FC48EA5AF2D41F201C47BE3@us-bv-m23.global.tektronix.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <57b26fdcbffc2e1577e3438c59b94f04@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Different Page Size Support in Linux on PPC870
Date: Sat, 4 Mar 2006 12:11:27 -0500
To: <atul.sabharwal@exgate.tek.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 3, 2006, at 9:38 PM, <atul.sabharwal@exgate.tek.com> wrote:

> On PPC870, does the kernel only support 4K pages?

The CONFIG_PIN_TLB will get you 8M pages for the kernel
space, and likely be a good solution for you.  We have experimented
with various dynamic replace methods for the past several years,
but I still haven't found a solution I like.


	-- Dan
