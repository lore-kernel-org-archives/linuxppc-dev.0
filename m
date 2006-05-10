Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 0CAB9679F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 03:46:06 +1000 (EST)
In-Reply-To: <1147279763.23931.32.camel@excalibur.timesys.com>
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
	<1147204345.3139.11.camel@excalibur.timesys.com>
	<3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
	<1147274635.23931.17.camel@excalibur.timesys.com>
	<1147279763.23931.32.camel@excalibur.timesys.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6CE25E1C-0F7A-4644-926E-746C17A7A851@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: IMAP_ADDR on PPC 8xx
Date: Wed, 10 May 2006 13:45:25 -0400
To: Walter L. Wimer III <walt.wimer@timesys.com>
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


On May 10, 2006, at 12:49 PM, Walter L. Wimer III wrote:

> FYI, here's a table from the "MPC885ADS PowerQUICC(tm) Application
> Development System User's Guide", available on Freescale's website.
> This table seems to confirm how they've configured their U-Boot -- the
> IMMR is set to 0x02200000...

Freescale never ported U-Boot to the MPC855ADS platform, and
I don't believe it came with any software at all.  This IMMR value was
chosen to be backward compatible with some old software tools to
get a compact address space without the need of using the MMU,
long before we had Linux running on the platform.

> This may be fine for non-Linux purposes, but it looks like we need to
> spread some gospel to Freescale regarding the correct IMMR address for
> U-Boot / Linux....

I think you better be pointing fingers at the clueless person that
provided the software you have, as it didn't come from Freescale nor
any of the public U-Boot sources.

Thanks.

	-- Dan
