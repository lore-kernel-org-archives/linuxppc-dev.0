Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id EA24A67BEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 21:51:48 +1000 (EST)
In-Reply-To: <1156327238.6735.9.camel@lamorak.int.avalon.com.au>
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
	<20060822142233.GA21339@gate.crashing.org>
	<1156327238.6735.9.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6708F23D-0883-4F5F-A7A4-F5B161DB5F64@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: ioremap() fails for >64 MB
Date: Wed, 23 Aug 2006 07:51:40 -0400
To: Phil.Nitschke@avalon.com.au
Cc: Matt Porter <mporter@embeddedalley.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 23, 2006, at 6:00 AM, Phil Nitschke wrote:

> Since my (2 GB) memory is within the (4 GB) addressable by a 32-bit
> processor, why do I need high memory at all?

Because the processor used virtual memory addressing, and
we divide this 4G virtual space up among application, kernel,
IO mapping, etc.  The kernel can't map the whole 4G (or even
the 2G) physical space at one time.


> I avoided this simply because I wanted to load/unload my driver  
> (during
> development),

My personal preference is to debug drivers in a development
mode by building them into the kernel.  I find it easier to debug,
and you are also likely to be rebooting anyway :-)


	-- Dan
