Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E46EA6811B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 16:09:17 +1000 (EST)
In-Reply-To: <20050823053125.GB10386@dmt.cnet>
References: <20050823022011.GE9667@dmt.cnet>
	<f45653d49c79423af587cff97181ac74@embeddededge.com>
	<20050823053125.GB10386@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f46785569550b765cab6490976931ab7@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 23 Aug 2005 02:09:03 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Enabling 8xx debug mode
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 23, 2005, at 1:31 AM, Marcelo Tosatti wrote:

> I'm trying to use the debugging registers - seem to work (the example
> is a data breakpoint). Just need a real interrupt handler,...

yes, that's the right idea.  It's easier with a BDI2000, though :-)

Have fun!

	-- Dan
