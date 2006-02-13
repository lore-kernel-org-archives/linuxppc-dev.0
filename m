Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 59214679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 03:14:30 +1100 (EST)
In-Reply-To: <43F08EF7.3060109@dgt.com.pl>
References: <43F08EF7.3060109@dgt.com.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0744a8b48857d469b3d4ceff6f7fd40f@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: arch/ppc/82xx_io/uart.c bug found
Date: Mon, 13 Feb 2006 11:14:16 -0500
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
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


On Feb 13, 2006, at 8:51 AM, Wojciech Kromer wrote:

> here is orignal uart.c

Three things....

One, this code is obsolete and isn't used any more.
Two, it's not a bug, just a feature enhancement.
Three, if you want us to actually do something about
this I need a real patch against an up to date
public source tree and indication it was actually
tested on some platform.

Thanks.

	-- Dan
