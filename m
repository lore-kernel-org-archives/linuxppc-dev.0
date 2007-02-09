Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 1BF94DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:20:11 +1100 (EST)
In-Reply-To: <1170969965.2620.345.camel@localhost.localdomain>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Discussion about iopa()
Date: Fri, 9 Feb 2007 12:13:28 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 4:26 PM, Benjamin Herrenschmidt wrote:

> I'm really not fan of it.

That's because I think it's a terribly useful function
and the first step toward some orthogonal VM APIs. :-)

No one liked my idea of virtual interrupt mapping
years ago when the 8xx showed up with the
CPM and I needed a way to handle some
non-PC interrupt controller.......


Thanks.

	-- Dan
