Return-Path: <bwarren@qstreams.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 6655767B1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 23:47:27 +1000 (EST)
Subject: Re: A question about power on
From: Ben Warren <bwarren@qstreams.com>
To: enorm <enorm@126.com>
In-Reply-To: <001401c6dd6e$a01d65a0$a309a8c0@enorm>
References: <001401c6dd6e$a01d65a0$a309a8c0@enorm>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 09:47:24 -0400
Message-Id: <1158846445.31490.2.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-21 at 19:11 +0800, enorm wrote:
> After power on, cpu reads instruction from certain addr. But how does it 
> know how many bits he can read at once. 

This can't be generalized.  Read the "Reset, Clocking and
Initialization", or equivalent, chapter of your CPU's reference manual.
