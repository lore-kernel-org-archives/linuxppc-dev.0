Return-Path: <dan@embeddedalley.com>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by ozlabs.org (Postfix) with SMTP id E77E9DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 10:30:47 +1100 (EST)
In-Reply-To: <348656.85285.qm@web45609.mail.sp1.yahoo.com>
References: <348656.85285.qm@web45609.mail.sp1.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A54CDFF0-EF7A-445B-8A1E-E211E5D267D9@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: How to map addresses beyond 4GB
Date: Fri, 23 Nov 2007 15:23:55 -0800
To: Dell Query <dell.query@yahoo.com>
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


On Nov 22, 2007, at 2:42 AM, Dell Query wrote:

> May I know how to map this one?

Just call ioremap() as usual.  It will understand the > 4G
physical address and return a useful virtual address
to you.

	-- Dan
