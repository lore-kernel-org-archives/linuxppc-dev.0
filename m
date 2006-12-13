Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id D7AAC67C0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 03:35:48 +1100 (EST)
Subject: Re: Floating Point Operation in Kernel
From: Ben Warren <bwarren@qstreams.com>
To: jimmy liu <jimmyzhmliu@yahoo.com>
In-Reply-To: <46717.30845.qm@web53109.mail.yahoo.com>
References: <46717.30845.qm@web53109.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 11:35:45 -0500
Message-Id: <1166027746.2627.85.camel@saruman.qstreams.net>
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

On Wed, 2006-12-13 at 08:20 -0800, jimmy liu wrote:
> We has a hardware driver need the floating point
> operation to do timing recover. Maybe, we have to do
> it in user space.
> 
Have you considered doing the math in fixed point instead?  I realize
that certain data sets make this difficult but this has been a standard
technique in resource-constrained systems forever.

regards,
Ben
