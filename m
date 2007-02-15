Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.mud.yahoo.com (smtp104.biz.mail.mud.yahoo.com
	[68.142.200.252]) by ozlabs.org (Postfix) with SMTP id 04414DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 09:40:35 +1100 (EST)
In-Reply-To: <E1HHkAL-0005Xl-2f@jdl.com>
References: <E1HHkAL-0005Xl-2f@jdl.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 14:33:47 -0800
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 15, 2007, at 9:13 AM, Jon Loeliger wrote:

> New syntax d#, b#, o# and h# allow for an explicit prefix
> on cell values to specify their base.  Eg: <d# 123>

Why do we need yet another syntax?  Everyone
else, including most silicon documentation, uses
the standard "C" syntax 0x for hex, 0 for octal, and
nothing for decimal.  If really needed binary, we
could us the '0b'.  Of the few dts files I've done,
anything to make this easier, rather than inventing
something new, would be appreciated.

Thanks.

	-- Dan
