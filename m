Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0C092BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Oct 2004 13:19:27 +1000 (EST)
In-Reply-To: <20041017123045.GA25808@xyzzy>
References: <BCEFJBPJCGFCNMMMIDBHMEIKCIAA.Joakim.Tjernlund@lumentis.se>
	<Pine.LNX.4.60.0410141824300.24365@localhost.localdomain>
	<20041014224128.GE19791@smtp.west.cox.net>
	<Pine.LNX.4.60.0410170702410.3826@localhost.localdomain>
	<20041017123045.GA25808@xyzzy>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D5DA4513-20B4-11D9-AC5A-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sun, 17 Oct 2004 23:21:43 -0400
To: "Dale Farnsworth" <dale@farnsworth.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 17, 2004, at 8:30 AM, Dale Farnsworth wrote:

> Yes, that's already the case for most ppc platforms.  The only thing
> that keeps it from being true for 8xx is that it doesn't work yet
> in the linux-2.5 tree.

That's not all of it.  The 8xx doesn't work in any 2.5/2.6 tree, but
there is still stuff that hasn't moved from linuxppc-2.5 into linux-2.5,
just like we left lots of stuff behind in the linuxppc-2.4 tree.  Kinda
sad this happens.


	-- Dan
