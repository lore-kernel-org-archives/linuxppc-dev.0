Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.mud.yahoo.com (smtp102.biz.mail.mud.yahoo.com
	[68.142.200.237]) by ozlabs.org (Postfix) with SMTP id 5CB0BDDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 10:37:44 +1100 (EST)
In-Reply-To: <20070215225739.GA21654@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
	<20070215225739.GA21654@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <79929A88-229C-41D7-A8E8-3191743A3EFF@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 15:37:36 -0800
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 15, 2007, at 2:57 PM, David Gibson wrote:

> Yes, but hex-by-default is already implemented and out there.  We
> can't change it without breaking compatibility horribly.

Compatibility with what?  The few dts files that exist
that are still all changing frequently due to other
tool modifications?  I'd prefer to change them now,
rather than propagate this new syntax.

Thanks.

	-- Dan
