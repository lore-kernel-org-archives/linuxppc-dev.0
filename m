Return-Path: <hollis@penguinppc.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by ozlabs.org (Postfix) with ESMTP id 1E96E67B1D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 05:21:28 +1000 (EST)
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
From: Hollis Blanchard <hollis@penguinppc.org>
To: jfaslist <jfaslist@yahoo.fr>
In-Reply-To: <447C4D4F.2020808@yahoo.fr>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>
	<17516.64514.854281.64425@cargo.ozlabs.ibm.com>
	<1148593014.15517.32.camel@basalt.austin.ibm.com>
	<447C20C4.50804@yahoo.fr>
	<ecea6f4aafae5a453662340020d4cc88@kernel.crashing.org>
	<447C4D4F.2020808@yahoo.fr>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:21:54 -0500
Message-Id: <1149016914.7177.65.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[resend from the correct email address]

On Tue, 2006-05-30 at 15:49 +0200, jfaslist wrote:
> > Hollis' latest patch is needed still.  We agreed not to solve it
> > completely correctly yet, as we'll need more surgery in other parts
> > of the PowerPC kernel first.
> I am trying to apply it on a 2.6.16.18 kernel but the two hunks of it 
> are rejected. Any specific version to use?

You could look at the file to see why you're getting rejects. The patch
wasn't committed until 26 May, and 2.6.16.18 was released on 22 May, so
it's more likely you've done something on your side like try to apply
the patch twice (e.g. the original version and then the final version).

-Hollis
