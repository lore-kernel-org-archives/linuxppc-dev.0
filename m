Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 81AFA679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Mar 2006 00:15:51 +1100 (EST)
In-Reply-To: <200603100822.42764.david.jander@protonic.nl>
References: <1CFEB358338412458B21FAA0D78FE86D02CABEE3@rennsmail02.eu.thmulti.com>
	<200603100822.42764.david.jander@protonic.nl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <da161c5383a7c1645080b918b0fd30ef@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Stable Linux kernel 2.6 for MPC8XX
Date: Fri, 10 Mar 2006 08:16:10 -0500
To: David Jander <david.jander@protonic.nl>
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


On Mar 10, 2006, at 2:22 AM, David Jander wrote:

> I believe most of those observations and measurements are not valid 
> anymore.
> Kernel 2.6 for 8xx has come a long way since this article was written.

They are still valid, we just have more knowledge about how to
configure the kernels and have added some features you can
use to mitigate the performance issues.  The Linux 2.6 kernel
is simply bigger than 2.4, and on these small, resource challenged
processors, you need to very carefully configure the kernels to
your requirements.

Thanks.


	-- Dan
